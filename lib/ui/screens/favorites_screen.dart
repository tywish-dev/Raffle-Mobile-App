import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/ui/providers/user_auth_provider.dart';
import '../widgets/app_bar/custom_app_bar.dart';
import '../widgets/cart/cart_widget.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

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
          title: "Favorilerim",
          isMain: true,
          isProfile: true,
        ),
        body: Column(
          children: [
            userAuthProvider.getFavorites.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                      itemCount: userAuthProvider.getFavorites.length,
                      itemBuilder: (context, index) {
                        return CartProduct(
                          product: userAuthProvider.getFavorites[index],
                          isTicket: false,
                          isCart: false,
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
