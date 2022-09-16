import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_ui/colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_ui/common/utils/utills.dart';
import 'package:whatsapp_ui/common/widgets/custom_button.dart';
import 'package:whatsapp_ui/features/auth/controller/auth_controller.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static const routeName = '/login-screen';

  LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final phoneController = TextEditingController();
  Country? country;
  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    void pickCountry() {
      showCountryPicker(
          context: context,
          onSelect: (Country _country) {
            setState(() {
              country = _country;
            });
          });
    }

    void sendPhoneNumber() {
      String phoneNumber = phoneController.text.trim();
      if (country != null && phoneNumber.length > 9) {
        ref
            .read(authControllerProvider)
            .signInWithPhone(context, '+${country!.phoneCode}$phoneNumber');
      } else {
        showSnackBar(context: context, content: "fill out all the fields");
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Enter your phone number "),
        elevation: 0,
        backgroundColor: backgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Whatsapp will need to verify your phone number"),
            const SizedBox(
              height: 10,
            ),
            TextButton(
                onPressed: () => pickCountry(),
                child: const Text("pick country ")),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                country != null
                    ? Text("+" + country!.phoneCode.toString())
                    : const Text(""),
                const SizedBox(width: 10),
                SizedBox(
                  width: size.width * 0.7,
                  child: TextField(
                    controller: phoneController,
                    decoration:
                        const InputDecoration(hintText: 'phone number '),
                  ),
                )
              ],
            ),
            SizedBox(
              height: size.height * 0.5,
            ),
            SizedBox(
              width: 90,
              child: CusttomButton(text: "NEXT", onPressed: sendPhoneNumber),
            )
          ],
        ),
      ),
    );
  }
}
