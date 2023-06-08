import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/data/models/product_model.dart';
import '/ui/providers/product_provider.dart';
import '/data/constants/constants.dart';

class QuantityWidget extends StatelessWidget {
  const QuantityWidget({super.key, required this.product});
  final Product product;
  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of<ProductProvider>(context);
    return Container(
      width: MediaQuery.of(context).size.width * 0.25,
      height: MediaQuery.of(context).size.height * 0.07,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          width: 1,
          color: mainBlack,
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.021,
          ),
          GestureDetector(
            onTap: () {
              if (productProvider.getQuantity <= 1) {
                productProvider.setQty(1);
              } else {
                productProvider.decreaseQty();
              }
            },
            child: Text(
              "-",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: mainBlack,
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.025,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.125,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                VerticalDivider(
                  width: 1,
                  color: mainBlack,
                ),
                Text(
                  productProvider.getQuantity.toString(),
                  style: TextStyle(fontSize: 17, color: mainBlack),
                ),
                VerticalDivider(
                  width: 1,
                  color: mainBlack,
                ),
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.02,
          ),
          GestureDetector(
            onTap: () {
              if (productProvider.getQuantity >=
                  int.tryParse(product.quantity!)!) {
                productProvider.setQty(int.tryParse(product.quantity!)!);
              } else {
                productProvider.increaseQty();
              }
            },
            child: Text(
              "+",
              style: TextStyle(fontWeight: FontWeight.bold, color: mainBlack),
            ),
          ),
        ],
      ),
    );
  }
}
