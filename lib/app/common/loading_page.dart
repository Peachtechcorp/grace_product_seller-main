import 'package:flutter/material.dart';
import 'package:grace_product_seller/app/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  initAuth(BuildContext context) async {
    await Provider.of<AuthProvider>(context).initialize();
  }

  @override
  Widget build(BuildContext context) {
    initAuth(context);
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
