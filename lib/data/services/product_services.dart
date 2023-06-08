import 'dart:convert';
import 'package:http/http.dart' as http;
import '/data/models/product_model.dart';
import '../constants/constants.dart';

class ProductServices {
  Uri getUrl(String category) =>
      Uri.parse("${baseUrl}products/$category/.json");
  Uri getIdUrl(String category, String id) =>
      Uri.parse("${baseUrl}products/$category/$id/.json");

  Future<Product?> postProduct(Product product, String category) async {
    http.Response response = await http.post(
      getUrl(category),
      body: product.toJson(),
      headers: {'Content-Type': "application/json"},
    );
    if (response.statusCode >= 200 && response.statusCode < 300) {
      var data = jsonDecode(response.body);
      product.id = data["name"];
      return product;
    }
    return null;
  }

  Future<List<Product>?> getProducts(String category) async {
    http.Response response = await http.get(getUrl(category));
    List<String> keys = [];
    List<Product> products = [];
    var data = jsonDecode(response.body);
    if (data != null) {
      if (response.statusCode >= 200 && response.statusCode < 300) {
        keys.addAll(data.keys);
        for (var i = 0; i < data.length; i++) {
          Product product = Product.fromMap(data[keys[i]]);
          product.id = keys[i];
          products.add(product);
        }
      }
    }
    return products;
  }

  Future<Product?> getProductById(String id, String category) async {
    http.Response response = await http.get(getUrl("$category/$id"));
    var data = jsonDecode(response.body);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      Product product = Product.fromMap(data);
      return product;
    }
    return null;
  }

  Future<bool?> updateProductById(
      String id, Product product, String category) async {
    http.Response response = await http.put(
      getIdUrl(category, id),
      body: product.toJson(),
      headers: {'Content-Type': "application/json"},
    );

    return response.statusCode >= 200 && response.statusCode < 300;
  }
}
