import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/ui/providers/product_provider.dart';
import '/data/constants/constants.dart';
import '/ui/providers/category_provider.dart';

enum CategoriesList { vehicles, furnishing, tech, collection, secondHand }

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    CategoryProvider provider = Provider.of<CategoryProvider>(context);
    ProductProvider productProvider = Provider.of<ProductProvider>(context);
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.055,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: CategoriesList.values.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 10),
            child: ElevatedButton(
              onPressed: () async {
                provider.setSelectedIndex(index);
                await productProvider
                    .getAllProducts(CategoriesList.values[index].name);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: provider.getSelectedIndex == index
                    ? mainGreen
                    : Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                side: BorderSide(
                    width: provider.getSelectedIndex == index ? 0 : 1,
                    color: mainGray),
                elevation: 0,
              ),
              child: Text(
                provider
                    .fixCategoryName(CategoriesList.values[index].name.trim()),
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: provider.getSelectedIndex == index
                      ? Colors.white
                      : mainGray,
                  fontSize: 18,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
