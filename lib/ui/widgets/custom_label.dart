import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import '/data/constants/constants.dart';
import 'dart:math' as math;

class CustomLabel extends StatelessWidget {
  const CustomLabel(
      {super.key,
      required this.label,
      this.onTap,
      required this.icon,
      required this.isTicket});
  final String label;
  final IconData icon;
  final Function()? onTap;
  final bool isTicket;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.08,
        child: Padding(
          padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.05,
            right: MediaQuery.of(context).size.width * 0.05,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Transform.rotate(
                    angle: isTicket == true ? -math.pi / 4 : 0,
                    child: Icon(
                      icon,
                      color: mainGreen,
                      size: 40,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.05,
                  ),
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 20,
                      color: mainBlack,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    BootstrapIcons.caret_right_fill,
                    color: mainGray,
                  )
                ],
              ),
              Divider(
                height: 1,
                color: mainBlack,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
