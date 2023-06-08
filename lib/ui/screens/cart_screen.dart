// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/ui/providers/product_provider.dart';
import '/ui/providers/user_auth_provider.dart';
import '/data/constants/constants.dart';
import '/ui/widgets/custom_button.dart';
import '/ui/widgets/cart/cart_widget.dart';
import '/ui/widgets/app_bar/custom_app_bar.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    UserAuthProvider userAuthProvider = Provider.of<UserAuthProvider>(context);
    ProductProvider productProvider = Provider.of<ProductProvider>(context);
    return GestureDetector(
      onPanUpdate: (details) {
        if (details.delta.dx > 25) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const CustomAppBar(
          title: "Sepet",
          isMain: false,
          isProfile: false,
        ),
        body: userAuthProvider.getCartProducts.isNotEmpty
            ? Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Consumer<UserAuthProvider>(
                    builder: (context, data, child) => Expanded(
                      child: ListView.builder(
                        itemCount: data.getCartProducts.length,
                        itemBuilder: (context, index) {
                          return CartProduct(
                            product: data.getCartProducts[index],
                            isTicket: false,
                            isCart: true,
                            isWinner: false,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              )
            : const SizedBox.shrink(),
        bottomNavigationBar: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: CustomButton(
                  text: "Satın Al",
                  bgColor: mainBlack,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text("Sepeti Onaylıyor musunuz?"),
                        actions: [
                          CustomButton(
                            text: "Evet",
                            bgColor: mainGreen,
                            onPressed: () async {
                              await userAuthProvider.emptyCart();
                              await userAuthProvider.getActiveTicketsF(
                                userAuthProvider.user!.localId!,
                              );

                              await productProvider
                                  .getAllProducts("furnishing");
                              await productProvider.getAllProducts("tech");
                              await productProvider
                                  .getAllProducts("collection");
                              await productProvider
                                  .getAllProducts("secondHand");
                              await productProvider.getAllProducts("vehicles");
                              Navigator.pop(context);
                            },
                          ),
                          CustomButton(
                            text: "Hayır",
                            bgColor: mainBlack,
                            onPressed: () async {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
