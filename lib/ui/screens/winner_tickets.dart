import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_auth_provider.dart';
import '../widgets/app_bar/custom_app_bar.dart';
import '../widgets/cart/cart_widget.dart';

class WinnerTicketsScreen extends StatelessWidget {
  const WinnerTicketsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    UserAuthProvider userAuthProvider = Provider.of<UserAuthProvider>(context);

    return GestureDetector(
      onPanUpdate: (details) {
        if (details.delta.dx > 25) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: const CustomAppBar(
          title: "Kazandığım Biletler",
          isMain: true,
          isProfile: true,
        ),
        body: Column(
          children: [
            userAuthProvider.getWinnerTickets.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                      itemCount: userAuthProvider.getWinnerTickets.length,
                      itemBuilder: (context, index) {
                        return CartProduct(
                          product: userAuthProvider.getWinnerTickets[index],
                          isTicket: true,
                          isCart: true,
                          isWinner: true,
                        );
                      },
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
