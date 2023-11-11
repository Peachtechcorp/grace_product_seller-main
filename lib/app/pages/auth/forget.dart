import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grace_product_seller/app/common/button_text.dart';
import 'package:grace_product_seller/app/common/custom_button.dart';
import 'package:grace_product_seller/app/common/error_message.dart';
import 'package:grace_product_seller/app/common/spinkit_loader.dart';
import 'package:grace_product_seller/app/pages/auth/otp.dart';
import 'package:grace_product_seller/app/provider/auth_provider.dart';
import 'package:grace_product_seller/app/styles/styles.dart';
import 'package:provider/provider.dart';

class ForgetPasswordPage extends StatelessWidget {
  const ForgetPasswordPage({super.key});

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
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: media.width * 0.1),
                SvgPicture.asset(
                  'assets/icons/forget_password.svg',
                ),
                SizedBox(height: media.width * 0.1),
                const ForgetPasswordForm(),
                SizedBox(height: media.width * 0.1),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ForgetPasswordForm extends StatefulWidget {
  const ForgetPasswordForm({super.key});

  @override
  State<ForgetPasswordForm> createState() => _ForgetPasswordFormState();
}

class _ForgetPasswordFormState extends State<ForgetPasswordForm> {
  String errMsg = '';
  bool isLoading = false;

  final formKey = GlobalKey<FormState>();
  final phoneCtrl = TextEditingController();

  @override
  void dispose() {
    phoneCtrl.dispose();
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
          errMsg.isNotEmpty ? ErrorMessage(message: errMsg) : const SizedBox(),
          Padding(
            padding: EdgeInsets.only(left: media.width * 0.04),
            child: Text(
              'Enter your phone number',
              style: labelStyle(media),
            ),
          ),
          SizedBox(height: media.width * 0.02),
          TextFormField(
            controller: phoneCtrl,
            decoration: defaultDecoration(
              media: media,
              hintText: 'Enter your phone number',
            ),
          ),
          SizedBox(height: media.width * 0.07),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Center(
              child: Text('Back to sign in'),
            ),
          ),
          SizedBox(height: media.width * 0.05),
          CustomButton(
            onTap: isLoading
                ? null
                : () async {
                    if (formKey.currentState!.validate()) {
                      setState(() {
                        errMsg = '';
                        isLoading = true;
                      });

                      Map result = await auth.forgotPassword(phoneCtrl.text);

                      setState(() {
                        isLoading = false;
                      });

                      if (result['success'] && mounted) {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const OtpPage(),
                          ),
                        );
                      } else {
                        setState(() {
                          errMsg = result['message'];
                        });
                      }
                    }
                  },
            child: isLoading
                ? const SpinkitLoader()
                : const ButtonText(text: 'Submit'),
          ),
          SizedBox(height: media.width * 0.05),
          GestureDetector(
            onTap: () {},
            child: Center(
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    color: hintColor,
                    fontSize: media.width * twelve,
                  ),
                  children: [
                    const TextSpan(text: 'Not a member yet?'),
                    TextSpan(
                      text: ' Create account',
                      style: TextStyle(
                        color: buttonColor,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
