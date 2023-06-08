import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raffle_mobile_app/ui/providers/user_auth_provider.dart';
import 'package:raffle_mobile_app/ui/widgets/cart/cart_widget.dart';
import '/ui/widgets/app_bar/custom_app_bar.dart';

class ActiveTicketsScreen extends StatelessWidget {
  const ActiveTicketsScreen({super.key});

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
          title: "Aktif Biletlerim",
          isMain: true,
          isProfile: true,
        ),
        body: Column(
          children: [
            userAuthProvider.getActiveTickets.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                      itemCount: userAuthProvider.getActiveTickets.length,
                      itemBuilder: (context, index) {
                        return CartProduct(
                          product: userAuthProvider.getActiveTickets[index],
                          isTicket: true,
                          isCart: true,
                          isWinner: false,
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
