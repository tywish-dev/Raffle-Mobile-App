import 'dart:convert';
import '/data/models/product_model.dart';
import '/data/models/user_model.dart';
import 'package:http/http.dart' as http;
import '../constants/constants.dart';

class UserServices {
  Uri getUrl(String endpoint, idToken) =>
      Uri.parse("$baseUrl$endpoint.json?auth=$idToken");

  Uri getCartUrl(String endpoint) => Uri.parse("$baseUrl$endpoint.json");

  Future<User?> postUser(User user, String localId) async {
    http.Response response = await http.put(
      getUrl("users/$localId", user.localId),
      body: user.toJson(),
      headers: {'Content-Type': "application/json"},
    );
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return user;
    }
    return null;
  }

  Future<User?> getUserByLocalId(String localId, idToken) async {
    http.Response response = await http.get(getUrl("users/$localId", idToken));
    if (response.statusCode == 200) {
      var data = response.body;
      return User.fromJson(data);
    }
    return null;
  }

  Future<bool?> updateUserById(String localId, User user) async {
    http.Response response = await http.patch(
      getUrl("users/$localId", user.localId),
      body: user.toJson(),
      headers: {'Content-Type': "application/json"},
    );

    return response.statusCode >= 200 && response.statusCode < 300;
  }

  Future<bool?> addToCart(String uid, Product product, String id) async {
    http.Response response = await http.put(
      getCartUrl("users/$uid/cart/$id"),
      body: product.toJson(),
      headers: {'Content-Type': "application/json"},
    );

    return response.statusCode >= 200 && response.statusCode < 300;
  }

  Future<List<Product>?> getCartProducts(String uid) async {
    http.Response response = await http.get(getCartUrl("/users/$uid/cart/"));

    List<String> keys = [];
    List<Product> products = [];
    var data = jsonDecode(response.body);

    if (data != null) {
      if (response.statusCode >= 200 && response.statusCode < 300) {
        keys.addAll(data.keys);

        for (var i = 0; i < data.length; i++) {
          Product product = Product.fromMap(data[keys[i]]);
          products.add(product);
        }
      }
    }

    return products;
  }

  Future<bool?> deleteCartProduct(String uid, String id) async {
    http.Response response =
        await http.delete(getCartUrl("/users/$uid/cart/$id"));

    return response.statusCode >= 200 && response.statusCode < 300;
  }

  Future<bool?> addActiveTickets(String uid, Product product) async {
    http.Response response = await http.post(
      getCartUrl("users/$uid/activeTickets/"),
      body: product.toJson(),
      headers: {'Content-Type': "application/json"},
    );

    return response.statusCode >= 200 && response.statusCode < 300;
  }

  Future<List<Product>?> getActiveTickets(String uid) async {
    http.Response response =
        await http.get(getCartUrl("users/$uid/activeTickets/"));

    List<String> keys = [];
    List<Product> products = [];
    var data = jsonDecode(response.body);
    if (data != null) {
      if (response.statusCode >= 200 && response.statusCode < 300) {
        keys.addAll(data.keys);
        for (var i = 0; i < data.length; i++) {
          Product product = Product.fromMap(data[keys[i]]);
          products.add(product);
        }
      }
    }

    return products;
  }

  Future<bool?> emptyCart(String uid) async {
    http.Response response = await http.delete(getCartUrl("users/$uid/cart"));

    return response.statusCode >= 200 && response.statusCode < 300;
  }

  Future<bool?> addFavorites(String uid, Product product, String id) async {
    http.Response response = await http.put(
      getCartUrl("users/$uid/favs/$id"),
      body: product.toJson(),
      headers: {'Content-Type': "application/json"},
    );

    return response.statusCode >= 200 && response.statusCode < 300;
  }

  Future<bool?> deleteFavorites(String uid, String id) async {
    http.Response response =
        await http.delete(getCartUrl("users/$uid/favs/$id"));

    return response.statusCode >= 200 && response.statusCode < 300;
  }

  Future<List<Product>?> getFavorites(String uid) async {
    http.Response response = await http.get(getCartUrl("users/$uid/favs/"));

    List<String> keys = [];
    List<Product> products = [];
    var data = jsonDecode(response.body);

    if (data != null) {
      if (response.statusCode >= 200 && response.statusCode < 300) {
        keys.addAll(data.keys);
        for (var i = 0; i < data.length; i++) {
          Product product = Product.fromMap(data[keys[i]]);
          products.add(product);
        }
      }
    }
    return products;
  }

  Future<bool?> deleteActiveTicket(String uid, String id) async {
    http.Response response =
        await http.delete(getCartUrl("users/$uid/activeTickets/$id"));

    return response.statusCode >= 200 && response.statusCode < 300;
  }

  Future<List<String>?> getActiveTicketsKeys(String uid) async {
    http.Response response =
        await http.get(getCartUrl("users/$uid/activeTickets"));

    List<String> keys = [];
    var data = jsonDecode(response.body);

    if (data != null) {
      if (response.statusCode >= 200 && response.statusCode < 300) {
        keys.addAll(data.keys);
      }
    }

    return keys;
  }
}
