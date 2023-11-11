import 'package:flutter/foundation.dart';
import 'package:grace_product_seller/env.dart';

class Api {
  static const String baseUrl =
      kReleaseMode ? Config.appProdUrl : Config.appDevUrl;

  static const String login = '$baseUrl/auth/login';
  static const String logout = '$baseUrl/auth/logout';
  static const String register = '$baseUrl/auth/register';
  static const String forgetPassword = '$baseUrl/auth/forget-password';
  static const String verifyOtp = '$baseUrl/auth/verify-otp';
  static const String resetPassword = '$baseUrl/auth/reset-password';

  static const String dashboard =
      '$baseUrl/seller/{agent}/dashboard-statistics';

  static const String orders = '$baseUrl/orders?agent_id={agent}';
  static const String showOrder = '$baseUrl/orders/{id}';
}
