import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/ui/providers/user_auth_provider.dart';
import '/ui/providers/product_provider.dart';
import '/data/models/product_model.dart';
import '/data/constants/constants.dart';

class CustomHeart extends StatelessWidget {
  const CustomHeart({super.key, required this.product});
  final Product product;
  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of<ProductProvider>(context);
    UserAuthProvider userAuthProvider = Provider.of<UserAuthProvider>(context);
    return GestureDetector(
      onTap: () async {
        product.isFavorite = !product.isFavorite!;
        await productProvider.updateProductById(
            product.id!, product, product.category);
        await productProvider.getAllProducts(product.category);

        if (product.isFavorite == true) {
          await userAuthProvider.addFavorites(
              userAuthProvider.user!.localId!, product.id!, product);
        } else {
          await userAuthProvider.deleteFavorites(
              userAuthProvider.user!.localId!, product.id!);
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.07,
        height: MediaQuery.of(context).size.height * 0.05,
        decoration: BoxDecoration(
          color: product.isFavorite == false ? Colors.white : mainGreen,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Icon(
            BootstrapIcons.heart_fill,
            color: product.isFavorite == false ? mainBlack : Colors.white,
            size: MediaQuery.of(context).size.width * 0.035,
          ),
        ),
      ),
    );
  }
}
