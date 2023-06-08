import 'package:flutter/material.dart';
import '/data/constants/constants.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.hintText,
      required this.isObsecure,
      required this.controller});
  final String hintText;
  final bool isObsecure;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      cursorColor: mainGray,
      obscureText: isObsecure,
      autocorrect: false,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      decoration: InputDecoration(
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: mainBlack),
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        hintText: hintText,
        hintStyle: TextStyle(color: mainGray),
      ),
    );
  }
}
