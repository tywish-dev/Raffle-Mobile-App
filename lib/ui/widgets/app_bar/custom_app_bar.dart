// ignore_for_file: use_build_context_synchronously

import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '/ui/providers/user_auth_provider.dart';
import '/ui/screens/cart_screen.dart';
import '/ui/screens/profile_screen.dart';
import '/ui/widgets/app_bar/circle_button.dart';
import '../../../data/constants/constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar(
      {super.key,
      required this.title,
      required this.isMain,
      required this.isProfile});
  final String title;
  final bool isMain;
  final bool isProfile;
  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    UserAuthProvider userAuthProvider = Provider.of<UserAuthProvider>(context);
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      centerTitle: false,
      title: Text(
        title,
        style: TextStyle(
          fontSize: 39,
          color: mainBlack,
        ),
      ),
      actions: [
        if (isProfile == false)
          GestureDetector(
            onTap: () async {
              if (isMain == true) {
                await userAuthProvider.getCart(userAuthProvider.user!.localId!);
                Navigator.push(
                  context,
                  PageTransition(
                      child: const CartScreen(), type: PageTransitionType.fade),
                );
              } else {
                Navigator.pop(context);
              }
            },
            child: CircleButton(
              icon: Icon(
                isMain == true
                    ? BootstrapIcons.bag_fill
                    : BootstrapIcons.house_fill,
                color: mainBlack,
                size: 30,
              ),
            ),
          ),
        const SizedBox(width: 10),
        if (isProfile == false)
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                    child: const ProfileScreen(),
                    type: PageTransitionType.fade),
              );
            },
            child: CircleButton(
              icon: Icon(
                BootstrapIcons.person_fill,
                color: mainBlack,
                size: 35,
              ),
            ),
          ),
        const SizedBox(width: 20),
      ],
    );
  }
}
