import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/ui/providers/product_provider.dart';
import '/ui/widgets/products/large_product.dart';
import '/ui/widgets/products/medium_product.dart';
import '/ui/widgets/categories.dart';
import '/ui/widgets/custom_search_bar.dart';
import '/ui/widgets/small_rectangle_button.dart';
import '/ui/widgets/app_bar/custom_app_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const CustomAppBar(
        title: "Keşfet",
        isMain: true,
        isProfile: false,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomSearchBar(),
                SmallRectangleButton(),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10),
              child: Categories(),
            ),
            Material(
              elevation: 10,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
            ),
            productProvider.getProducts.isNotEmpty
                ? SizedBox(
                    height: MediaQuery.of(context).size.height * 0.66,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Wrap(
                            direction: Axis.horizontal,
                            runSpacing: 20,
                            spacing: 20,
                            children: List.generate(
                              productProvider.getProducts.length,
                              (index) => index == 0
                                  ? LargeProduct(
                                      product: productProvider.getProducts[0])
                                  : MediumProduct(
                                      product:
                                          productProvider.getProducts[index],
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
