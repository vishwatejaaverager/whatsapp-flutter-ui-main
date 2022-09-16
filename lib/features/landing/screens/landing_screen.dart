import 'package:flutter/material.dart';
import 'package:whatsapp_ui/colors.dart';
import 'package:whatsapp_ui/common/widgets/custom_button.dart';
import 'package:whatsapp_ui/features/auth/screens/login_screen.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  void navigateToLoginScreen(BuildContext context) {
    Navigator.pushNamed(context, LoginScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 50,
          ),
          const Text(
            "Welcome to Whats up",
            style: TextStyle(fontSize: 33, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: size.height / 9,
          ),
          Center(
            child: Image.asset(
              'assets/bg.png',
              height: 340,
              width: 340,
            ),
          ),
          SizedBox(
            height: size.height / 20,
          ),
          const Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(
              "Read Privacy Policy. Tap to Agree",
              style: TextStyle(
                color: greyColor,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
              width: size.width * 0.75,
              child: CusttomButton(
                onPressed: () => navigateToLoginScreen(context),
                text: "Agree and Continue",
              ))
        ],
      )),
    );
  }
}
