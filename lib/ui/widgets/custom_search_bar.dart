import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:raffle_mobile_app/data/constants/constants.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      height: MediaQuery.of(context).size.height * 0.065,
      decoration: BoxDecoration(
        color: containerGray,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: TextField(
        cursorColor: mainGray,
        autocorrect: false,
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        decoration: InputDecoration(
          prefixIcon: const Icon(BootstrapIcons.search),
          prefixIconColor: mainGray,
          border: const OutlineInputBorder(borderSide: BorderSide.none),
          hintText: "Ara",
          hintStyle: TextStyle(color: mainGray),
        ),
      ),
    );
  }
}
