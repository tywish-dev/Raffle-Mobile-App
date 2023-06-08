// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';
import '../widgets/custom_button.dart';
import '/ui/providers/user_auth_provider.dart';
import '/data/models/product_model.dart';
import '/ui/widgets/products/add_to_card_button.dart';
import '/ui/widgets/products/quantity.dart';
import '/data/constants/constants.dart';
import '../widgets/products/large_heart.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key, required this.product});
  final Product product;
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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: BoxDecoration(
                  // color: mainGray.withOpacity(0.3),
                  color: containerGray,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Image.network(
                        product.img,
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.32,
                        fit: BoxFit.contain,
                      ),
                    ],
                  ),
                )),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.08,
              child: Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.05,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text(
                      //   product.category,
                      //   style: TextStyle(
                      //     fontSize: 16,
                      //     color: mainGreen,
                      //   ),
                      // ),
                      Text(
                        product.name,
                        style: TextStyle(
                          color: mainBlack,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  LargeCustomHeart(
                    product: product,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.05,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.05,
                right: MediaQuery.of(context).size.width * 0.05,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Açıklama",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: mainBlack,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Text(
                    product.desc,
                    style: TextStyle(
                      fontSize: 14,
                      color: mainGray,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.05,
                right: MediaQuery.of(context).size.width * 0.05,
              ),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${product.price} TL",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: mainBlack,
                        ),
                      ),
                      Text(
                        "${product.quantity} kaldı",
                        style: TextStyle(
                          fontSize: 20,
                          color: mainBlack,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  AddToCardButton(
                    onPressed: int.tryParse(product.quantity!)! <= 0
                        ? null
                        : () async {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text("Sepete Eklensin mi?"),
                                actions: [
                                  CustomButton(
                                    text: "Evet",
                                    bgColor: mainGreen,
                                    onPressed: () async {
                                      product.cartQty = productProvider
                                          .getQuantity
                                          .toString();
                                      await userAuthProvider.addToCart(
                                        userAuthProvider.user!.localId!,
                                        product.id!,
                                        product,
                                      );
                                      productProvider.setQty(1);
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
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.02,
                  ),
                  QuantityWidget(
                    product: product,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
          ],
        ),
      ),
    );
  }
}
