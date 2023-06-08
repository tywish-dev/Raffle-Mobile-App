import 'package:flutter/material.dart';
import 'package:raffle_mobile_app/data/constants/constants.dart';

class CircleButton extends StatelessWidget {
  const CircleButton({super.key, required this.icon});
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(
          color: mainGray,
          width: 1,
        ),
        shape: BoxShape.circle,
      ),
      child: icon,
    );
  }
}
