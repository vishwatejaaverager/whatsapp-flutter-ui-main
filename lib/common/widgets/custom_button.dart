import 'package:flutter/material.dart';
import 'package:whatsapp_ui/colors.dart';

class CusttomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const CusttomButton({Key? key, required this.text, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(color: blackColor),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: tabColor,
        minimumSize: const Size(double.infinity, 50)
      ),
    );
  }
}
