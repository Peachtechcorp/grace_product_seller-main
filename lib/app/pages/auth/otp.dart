import 'package:flutter/material.dart';
import 'package:grace_product_seller/app/common/button_text.dart';
import 'package:grace_product_seller/app/common/custom_button.dart';
import 'package:grace_product_seller/app/common/error_message.dart';
import 'package:grace_product_seller/app/common/spinkit_loader.dart';
import 'package:grace_product_seller/app/pages/auth/reset_password.dart';
import 'package:grace_product_seller/app/provider/auth_provider.dart';
import 'package:grace_product_seller/app/styles/styles.dart';
import 'package:provider/provider.dart';

class OtpPage extends StatelessWidget {
  const OtpPage({super.key});

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
                const OtpForm(),
                SizedBox(height: media.width * 0.1),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OtpForm extends StatefulWidget {
  const OtpForm({super.key});

  @override
  State<OtpForm> createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  final formKey = GlobalKey<FormState>();
  final ctrlOne = TextEditingController();
  final ctrlTwo = TextEditingController();
  final ctrlThree = TextEditingController();
  final ctrlFour = TextEditingController();

  final ctrlOneFocusNode = FocusNode();
  final ctrlTwoFocusNode = FocusNode();
  final ctrlThreeFocusNode = FocusNode();
  final ctrlFourFocusNode = FocusNode();

  String errMsg = '';
  bool isLoading = false;

  @override
  void dispose() {
    ctrlOne.dispose();
    ctrlTwo.dispose();
    ctrlThree.dispose();
    ctrlFour.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    var auth = Provider.of<AuthProvider>(context);

    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          errMsg.isNotEmpty ? ErrorMessage(message: errMsg) : const SizedBox(),
          Padding(
            padding: EdgeInsets.only(left: media.width * 0.04),
            child: Text(
              'Enter verification code',
              style: labelStyle(media),
            ),
          ),
          SizedBox(height: media.width * 0.02),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  focusNode: ctrlOneFocusNode,
                  controller: ctrlOne,
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      ctrlTwoFocusNode.requestFocus();
                    }
                  },
                  decoration: defaultDecoration(
                    media: media,
                    hintText: 'x',
                  ),
                ),
              ),
              SizedBox(width: media.width * 0.02),
              Expanded(
                child: TextFormField(
                  focusNode: ctrlTwoFocusNode,
                  controller: ctrlTwo,
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      ctrlThreeFocusNode.requestFocus();
                    }
                  },
                  decoration: defaultDecoration(
                    media: media,
                    hintText: 'x',
                  ),
                ),
              ),
              SizedBox(width: media.width * 0.02),
              Expanded(
                child: TextFormField(
                  focusNode: ctrlThreeFocusNode,
                  controller: ctrlThree,
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      ctrlFourFocusNode.requestFocus();
                    }
                  },
                  decoration: defaultDecoration(
                    media: media,
                    hintText: 'x',
                  ),
                ),
              ),
              SizedBox(width: media.width * 0.02),
              Expanded(
                child: TextFormField(
                  focusNode: ctrlFourFocusNode,
                  controller: ctrlFour,
                  decoration: defaultDecoration(
                    media: media,
                    hintText: 'x',
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: media.width * 0.07),
          GestureDetector(
            onTap: () {
              // Navigator.pop(context);
            },
            child: Center(
              child: Text.rich(
                TextSpan(
                    style: TextStyle(
                      fontSize: media.width * twelve,
                    ),
                    children: [
                      const TextSpan(text: 'If you didn\'t receive a code!'),
                      TextSpan(
                        text: ' Resend',
                        style: TextStyle(
                          color: buttonColor,
                        ),
                      ),
                    ]),
              ),
            ),
          ),
          SizedBox(height: media.width * 0.1),
          CustomButton(
            onTap: isLoading
                ? null
                : () async {
                    if (formKey.currentState!.validate()) {
                      setState(() {
                        errMsg = '';
                        isLoading = true;
                      });

                      String otp = ctrlOne.text +
                          ctrlTwo.text +
                          ctrlThree.text +
                          ctrlFour.text;

                      dynamic res = await auth.verifyOtp(otp);

                      setState(() {
                        isLoading = false;
                      });

                      if (res['success'] && mounted) {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const ResetPasswordPage(),
                          ),
                        );
                      } else {
                        setState(() {
                          errMsg = res['message'];
                        });
                      }
                    }
                  },
            child: isLoading
                ? const SpinkitLoader()
                : const ButtonText(text: 'Verify'),
          ),
          SizedBox(height: media.width * 0.05),
        ],
      ),
    );
  }
}
