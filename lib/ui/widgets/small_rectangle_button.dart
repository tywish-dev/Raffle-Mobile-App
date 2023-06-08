import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import '/data/constants/constants.dart';

class SmallRectangleButton extends StatelessWidget {
  const SmallRectangleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.065,
      width: MediaQuery.of(context).size.width * 0.15,
      decoration: BoxDecoration(
        color: mainGreen,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Center(
        child: Icon(
          BootstrapIcons.list,
          color: Colors.white,
          size: 40,
        ),
      ),
    );
  }
}
