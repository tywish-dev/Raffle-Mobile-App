import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '/data/models/product_model.dart';
import '/ui/screens/product_screen.dart';
import '/ui/widgets/products/heart.dart';
import '/data/constants/constants.dart';

class MediumProduct extends StatelessWidget {
  const MediumProduct({super.key, required this.product});
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
        width: MediaQuery.of(context).size.width * 0.425,
        height: MediaQuery.of(context).size.height * 0.22,
        decoration: BoxDecoration(
          color: containerGray,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Center(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.19,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.network(
                      product.img,
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: MediaQuery.of(context).size.height * 0.115,
                    ),
                    Text(
                      product.name,
                      style: const TextStyle(fontSize: 18),
                    ),
                    Text(
                      "${product.price} TL",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 17),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15, top: 5),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
                child: Row(
                  children: [
                    const Spacer(),
                    CustomHeart(
                      product: product,
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
