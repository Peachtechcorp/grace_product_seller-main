import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grace_product_seller/app/common/loading_page.dart';
import 'package:grace_product_seller/app/pages/auth/login.dart';
import 'package:grace_product_seller/app/pages/home_page/home_page.dart';
import 'package:grace_product_seller/app/provider/auth_provider.dart';
import 'package:grace_product_seller/app/provider/dashboard_provider.dart';
import 'package:grace_product_seller/app/provider/order_provider.dart';
import 'package:grace_product_seller/app/styles/styles.dart';
import 'package:provider/provider.dart';

void main() {
  final auth = AuthProvider();
  runApp(
    ChangeNotifierProvider(
      create: (_) => auth,
      child: MyApp(auth: auth),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.auth,
  }) : super(key: key);

  final AuthProvider auth;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DashboardProvider(auth)),
        ChangeNotifierProvider(create: (context) => OrderProvider(auth)),
      ],
      child: MaterialApp(
        title: 'Grace Product Seller',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: GoogleFonts.robotoTextTheme(),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent,
            elevation: 0,
            foregroundColor: Colors.black,
          ),
          scaffoldBackgroundColor: page,
        ),
        home: const Router(),
      ),
    );
  }
}

class Router extends StatelessWidget {
  const Router({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, auth, _) {
        switch (auth.authStatus) {
          case AuthStatus.uninitialized:
            return const LoadingPage();
          case AuthStatus.authenticated:
            return const HomePage();
          case AuthStatus.unaunthenticated:
            return const LoginPage();
          default:
            return const LoginPage();
        }
      },
    );
  }
}
