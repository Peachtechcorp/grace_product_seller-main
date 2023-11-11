import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:grace_product_seller/app/models/agent.dart';
import 'package:grace_product_seller/app/models/organization.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:grace_product_seller/app/utils/api.dart';
import 'package:grace_product_seller/app/models/user.dart';

enum AuthStatus {
  uninitialized,
  authenticating,
  authenticated,
  unaunthenticated
}

class AuthProvider extends ChangeNotifier {
  User? _user;
  String? _token;
  AuthStatus _status = AuthStatus.uninitialized;
  String _errorMsg = '';
  String _tempPhone = '';
  int? _currentAgent;

  User? get user => _user;
  String? get token => _token;
  AuthStatus get authStatus => _status;
  String get errMsg => _errorMsg;
  int? get currentAgent => _currentAgent;

  initialize() async {
    String? token = await getToken();

    if (token != null) {
      _token = token;
      _user = await getUser();
      _currentAgent = _user!.organizations.first.agents.first.id;
      _status = AuthStatus.authenticated;
    } else {
      _status = AuthStatus.unaunthenticated;
    }

    notifyListeners();
  }

  Future<void> login(String phone, String password) async {
    _status = AuthStatus.authenticating;
    notifyListeners();

    try {
      http.Response response = await http.post(
        Uri.parse(Api.login),
        body: {
          'email': phone,
          'password': password,
        },
        headers: {
          'Accept': 'application/json',
        },
      ).timeout(const Duration(seconds: 30));

      Map<String, dynamic> responseBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        _errorMsg = '';
        _token = responseBody['token'];
        _user = User.fromJson(responseBody['user']);
        _status = AuthStatus.authenticated;
        _currentAgent = _user!.organizations.first.agents.first.id;

        await setToken(responseBody['token']);
        await setUser(responseBody['user']);
      } else {
        _status = AuthStatus.unaunthenticated;

        if (responseBody.containsKey('data')) {
          _errorMsg = responseBody['data'];
        }

        if (responseBody.containsKey('errors')) {
          if (responseBody['errors'].containsKey('email')) {
            _errorMsg = responseBody['errors']['email'][0];
          } else if (responseBody['errors'].containsKey('password')) {
            _errorMsg = responseBody['errors']['password'][0];
          }
        }
      }
    } catch (e) {
      print(e);
      _token = null;
      _user = null;
      _status = AuthStatus.unaunthenticated;

      if (e is SocketException) {
        _errorMsg = 'Please check your internet connection!';
      } else if (e is TimeoutException) {
        _errorMsg = 'Service is unreachable, Try again later!';
      } else {
        _errorMsg = 'Service unavailable!';
      }
    }

    notifyListeners();
  }

  Future<Map> forgotPassword(String phone) async {
    dynamic result = {
      'success': false,
      'message': 'Unknown error.',
    };

    try {
      http.Response response = await http.post(
        Uri.parse(Api.forgetPassword),
        body: {
          'phone': phone,
        },
        headers: {
          'Accept': 'application/json',
        },
      );

      Map<String, dynamic> responseBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        _tempPhone = phone;
        result['success'] = true;
        return result;
      }

      if (response.statusCode == 422) {
        if (responseBody['errors'].containsKey('email')) {
          result['message'] = responseBody['errors']['email'][0];
          return result;
        }
      }
    } catch (e) {
      print(e);

      if (e is SocketException) {
        result['message'] = 'Please check your internet connection!';
      }

      if (e is TimeoutException) {
        result['message'] = 'Service is unreachable, Try again later!';
      }
    }

    return result;
  }

  Future<dynamic> verifyOtp(String otp) async {
    dynamic result = {
      'success': false,
      'message': 'Unknown error.',
    };

    try {
      http.Response response = await http.post(
        Uri.parse(Api.verifyOtp),
        body: {
          'otp': otp,
        },
        headers: {
          'Accept': 'application/json',
        },
      );

      Map<String, dynamic> responseBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        result['success'] = true;
        return result;
      }

      if (response.statusCode == 422) {
        if (responseBody['errors'].containsKey('otp')) {
          result['message'] = responseBody['errors']['otp'][0];
          return result;
        }
      }
    } catch (e) {
      print(e);

      if (e is SocketException) {
        result['message'] = 'Please check your internet connection!';
      }

      if (e is TimeoutException) {
        result['message'] = 'Service is unreachable, Try again later!';
      }
    }

    return result;
  }

  Future<dynamic> resetPassword(String password) async {
    dynamic result = {
      'success': false,
      'message': 'Unknown error.',
    };

    try {
      http.Response response = await http.post(
        Uri.parse(Api.resetPassword),
        body: {
          'email': _tempPhone,
          'password': password,
        },
        headers: {
          'Accept': 'application/json',
        },
      );

      Map<String, dynamic> responseBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        result['success'] = true;
        return result;
      }

      if (response.statusCode == 422) {
        if (responseBody['errors'].containsKey('email')) {
          result['message'] = responseBody['errors']['email'][0];
          return result;
        }

        if (responseBody['errors'].containsKey('password')) {
          result['message'] = responseBody['errors']['password'][0];
          return result;
        }
      }
    } catch (e) {
      print(e);

      if (e is SocketException) {
        result['message'] = 'Please check your internet connection!';
      }

      if (e is TimeoutException) {
        result['message'] = 'Service is unreachable, Try again later!';
      }
    }

    return result;
  }

  Future<void> logout() async {
    try {
      http.Response response = await http.post(
        Uri.parse(Api.logout),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );

      if (response.statusCode == 200) {
        await clearStorage();
      }
    } catch (e) {
      print(e);
    }

    notifyListeners();
  }

  setUser(dynamic user) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('user', jsonEncode(user));
  }

  Future<User?> getUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? userStr = sharedPreferences.getString('user');

    if (userStr != null) {
      User user = User.fromJson(jsonDecode(userStr));
      return user;
    }

    return null;
  }

  setToken(String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('token', token);
  }

  Future<String?> getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String? token = sharedPreferences.getString('token');

    return token;
  }

  clearStorage() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
  }

  List<Agent> getAgentsList() {
    List<Agent> agents = [];

    for (Organization organization in _user!.organizations) {
      for (Agent agent in organization.agents) {
        agents.add(agent);
      }
    }

    return agents;
  }

  void updateActiveAgent(int id) async {
    _currentAgent = id;
    notifyListeners();
  }
}
