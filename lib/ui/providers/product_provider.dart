import 'package:flutter/material.dart';
import '/data/services/product_services.dart';
import '/data/models/product_model.dart';

class ProductProvider with ChangeNotifier {
  List<Product>? _products = [];
  int _quantity = 1;
  Product? _product;

  Product get getProduct => _product!;
  List<Product> get getProducts => _products!;
  int get getQuantity => _quantity;

  ProductServices productServices = ProductServices();

  setQty(int i) {
    _quantity = i;
    notifyListeners();
  }

  increaseQty() {
    _quantity++;
    notifyListeners();
  }

  decreaseQty() {
    _quantity--;
    notifyListeners();
  }

  Future getAllProducts(String category) async {
    _products = await productServices.getProducts(category);
    notifyListeners();
  }

  Future addProduct(Product product, String category) async {
    _product = await productServices.postProduct(product, category);
    notifyListeners();
  }

  Future updateProductById(String id, Product product, String category) async {
    await productServices.updateProductById(id, product, category);
    notifyListeners();
  }
}
