import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grace_product_seller/app/common/button_text.dart';
import 'package:grace_product_seller/app/common/custom_button.dart';
import 'package:grace_product_seller/app/common/custom_icon_button.dart';
import 'package:grace_product_seller/app/common/spinkit_loader.dart';
import 'package:grace_product_seller/app/provider/auth_provider.dart';
import 'package:grace_product_seller/app/styles/styles.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: media.width * 1,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(media.width * pagePadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: media.width * 0.1),
                Text(
                  'Welcome back',
                  style: TextStyle(
                    fontSize: media.width * thirty,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: media.width * 0.04),
                Text(
                  'Login to your account',
                  style: TextStyle(
                    fontSize: media.width * twelve,
                    color: hintColor,
                  ),
                ),
                SizedBox(height: media.width * 0.1),
                const LoginForm(),
                SizedBox(height: media.width * 0.05),
                Center(
                  child: Text(
                    'or',
                    style: TextStyle(
                      fontSize: media.width * sixteen,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: media.width * 0.05),
                CustomIconButton(
                  onTap: () {},
                  text: 'Continue with Facebook',
                  icon: SvgPicture.asset('assets/social/facebook.svg'),
                ),
                SizedBox(height: media.width * 0.04),
                CustomIconButton(
                  onTap: () {},
                  text: 'Continue with Google',
                  icon: SvgPicture.asset('assets/social/google.svg'),
                ),
                SizedBox(height: media.width * 0.04),
                CustomIconButton(
                  onTap: () {},
                  text: 'Continue with Apple',
                  icon: SvgPicture.asset('assets/social/apple.svg'),
                ),
                SizedBox(height: media.width * 0.04),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final phoneCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    phoneCtrl.dispose();
    passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    final auth = Provider.of<AuthProvider>(context);
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          auth.errMsg.isNotEmpty
              ? Container(
                  width: media.width * 1,
                  padding: EdgeInsets.all(media.width * 0.02),
                  margin: EdgeInsets.only(bottom: media.width * 0.05),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(124, 195, 44, 44),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Wrap(
                    children: [
                      Text(
                        auth.errMsg,
                        style: TextStyle(
                          fontSize: media.width * twelve,
                        ),
                      ),
                    ],
                  ),
                )
              : const SizedBox(),
          Padding(
            padding: EdgeInsets.only(left: media.width * 0.04),
            child: Text(
              'Email address',
              style: labelStyle(media),
            ),
          ),
          SizedBox(height: media.width * 0.02),
          TextFormField(
            controller: phoneCtrl,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Email address is required';
              }
              return null;
            },
            decoration: defaultDecoration(
              media: media,
              hintText: 'Enter your email address',
            ),
          ),
          SizedBox(height: media.width * 0.05),
          Padding(
            padding: EdgeInsets.only(left: media.width * 0.04),
            child: Text(
              'Password',
              style: labelStyle(media),
            ),
          ),
          SizedBox(height: media.width * 0.02),
          TextFormField(
            controller: passwordCtrl,
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Password is required';
              }
              return null;
            },
            decoration: defaultDecoration(
              media: media,
              hintText: 'Enter your password',
            ),
          ),
          SizedBox(height: media.width * 0.05),
          CustomButton(
            onTap: auth.authStatus == AuthStatus.authenticating
                ? null
                : () async {
                    if (formKey.currentState!.validate()) {
                      await auth.login(phoneCtrl.text, passwordCtrl.text);
                    }
                  },
            child: auth.authStatus == AuthStatus.authenticating
                ? const SpinkitLoader()
                : const ButtonText(text: 'Login'),
          ),
        ],
      ),
    );
  }
}
