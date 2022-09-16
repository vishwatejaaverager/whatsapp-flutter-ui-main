import 'package:flutter/material.dart';
import 'package:whatsapp_ui/features/auth/screens/login_screen.dart';
import 'package:whatsapp_ui/features/auth/screens/otp_screen.dart';
import 'package:whatsapp_ui/features/auth/screens/user_information.dart';
import 'package:whatsapp_ui/features/select_contacts/screeens/select_contacts_screen.dart';
import 'package:whatsapp_ui/screens/mobile_chat_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginScreen.routeName:
      return MaterialPageRoute(builder: (context) => LoginScreen());
    case OTPScreen.routeName:
      final verificationId = settings.arguments as String;
      return MaterialPageRoute(
          builder: (context) => OTPScreen(
                verificationId: verificationId,
              ));
    case UserInformationScreen.routeName:
      return MaterialPageRoute(builder: (context) => UserInformationScreen());
    case SelectContactsScreen.routeName:
      return MaterialPageRoute(builder: (context) => SelectContactsScreen());
    case MobileChatScreen.routeName:
      final arguments = settings.arguments as Map<String, dynamic>;
      final name = arguments['name'];
      return MaterialPageRoute(builder: (context) => MobileChatScreen());
    default:
      return MaterialPageRoute(
          builder: (context) => const Scaffold(
                body: Text("Error bruh"),
              ));
  }
}
