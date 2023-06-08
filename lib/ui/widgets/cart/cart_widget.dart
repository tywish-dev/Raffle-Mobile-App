import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '/ui/widgets/products/heart.dart';
import '/ui/providers/user_auth_provider.dart';
import '/ui/screens/product_screen.dart';
import '/data/models/product_model.dart';
import '../../../data/constants/constants.dart';

class CartProduct extends StatelessWidget {
  const CartProduct({
    super.key,
    required this.product,
    required this.isTicket,
    required this.isCart,
    required this.isWinner,
  });
  final Product product;
  final bool isTicket;
  final bool isCart;
  final bool isWinner;
  @override
  Widget build(BuildContext context) {
    UserAuthProvider userAuthProvider = Provider.of<UserAuthProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.18,
        decoration: BoxDecoration(
          color: containerGray,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.05,
              ),
              Image.network(
                product.img,
                width: MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.height * 0.15,
                fit: BoxFit.contain,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.05,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        product.name,
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.2,
                      ),
                      isTicket == false
                          ? isCart == true
                              ? GestureDetector(
                                  onTap: () async {
                                    await userAuthProvider.deleteCartProduct(
                                        userAuthProvider.user!.localId!,
                                        product.id!);
                                  },
                                  child: const Icon(
                                    BootstrapIcons.trash,
                                  ),
                                )
                              : CustomHeart(product: product)
                          : const SizedBox.shrink(),
                    ],
                  ),
                  isWinner == false
                      ? isCart == true
                          ? Text(
                              '${product.cartQty} => ${(int.tryParse(product.cartQty!)! * int.tryParse(product.price)!)} TL',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            )
                          : const SizedBox.shrink()
                      : Text(
                          "Kazandınız!",
                          style: TextStyle(
                            color: mainGreen,
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        PageTransition(
                          child: ProductScreen(
                            product: product,
                          ),
                          type: PageTransitionType.fade,
                        ),
                      );
                    },
                    child: Text(
                      "Ürün Sayfasına Git >",
                      style: TextStyle(fontSize: 20, color: mainGreen),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
