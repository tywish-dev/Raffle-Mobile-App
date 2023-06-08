import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '/data/models/product_model.dart';
import '/ui/screens/product_screen.dart';
import '/data/constants/constants.dart';
import '/ui/widgets/custom_button.dart';
import 'heart.dart';

class LargeProduct extends StatelessWidget {
  const LargeProduct({super.key, required this.product});
  final Product product;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageTransition(
              child: ProductScreen(
                product: product,
              ),
              type: PageTransitionType.fade),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.18,
        decoration: BoxDecoration(
          color: containerGray,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Reklam",
                    style: TextStyle(
                      color: mainGreen,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.007,
                  ),
                  Text(
                    product.name,
                    style: TextStyle(
                      color: mainBlack,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Row(
                    children: [
                      CustomButton(
                        text: "Katıl",
                        bgColor: mainGreen,
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageTransition(
                                child: ProductScreen(
                                  product: product,
                                ),
                                type: PageTransitionType.fade),
                          );
                        },
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.05,
                      ),
                      Text(
                        "${product.price} TL",
                        style: TextStyle(
                          color: mainBlack,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  const Spacer(),
                  Image.network(
                    product.img,
                    width: MediaQuery.of(context).size.width * 0.35,
                    height: MediaQuery.of(context).size.height * 0.14,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15, top: 5),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
                child: Row(
                  children: [
                    const Spacer(),
                    Consumer(
                      builder: (context, value, child) => CustomHeart(
                        product: product,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
