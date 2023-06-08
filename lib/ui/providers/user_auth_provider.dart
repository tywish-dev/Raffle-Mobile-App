import 'dart:math';

import 'package:flutter/material.dart';
import '/data/models/ticket_model.dart';
import '/data/services/ticket_services.dart';
import '/data/services/product_services.dart';
import '/data/models/product_model.dart';
import '/data/services/user_services.dart';
import '/data/models/user_auth.dart';
import '/data/models/user_model.dart';
import '/data/services/auth_services.dart';

class UserAuthProvider with ChangeNotifier {
  List<Product>? _cartProducts = [];
  List<Product>? _activeTickets = [];
  List<Product>? _winnerTickets = [];
  List<Product>? _favorites = [];
  List<Ticket>? _tickets = [];
  List<String> _uidTicketList = [];
  List<String>? _activeTicketKeys = [];
  bool result = false;
  User? user = User();

  List<Product> get getCartProducts => _cartProducts!;
  List<Product> get getActiveTickets => _activeTickets!;
  List<Product> get getWinnerTickets => _winnerTickets!;
  List<Product> get getFavorites => _favorites!;
  List<String> get getActiveTicketKeys => _activeTicketKeys!;
  List<Ticket> get getTickets => _tickets!;

  AuthServices authServices = AuthServices();
  ProductServices productServices = ProductServices();
  UserServices userServices = UserServices();
  TicketServices ticketServices = TicketServices();

  Future signUp(UserAuth userAuth, User user) async {
    await authServices.signUp(userAuth, user);
    notifyListeners();
  }

  Future signInBoolean(UserAuth userAuth, User user) async {
    result = await authServices.signInBoolean(userAuth, user);
    notifyListeners();
  }

  Future addToCart(String uid, String id, Product product) async {
    await userServices.addToCart(uid, product, id);
    notifyListeners();
  }

  Future getCart(String uid) async {
    _cartProducts = await userServices.getCartProducts(uid);
    notifyListeners();
  }

  Future deleteCartProduct(String uid, String id) async {
    await userServices.deleteCartProduct(uid, id);
    await getCart(uid);
    notifyListeners();
  }

  Future addActiveTickets(String uid, Product product) async {
    await userServices.addActiveTickets(uid, product);
    notifyListeners();
  }

  setCartProducts(List<Product> p) {
    _cartProducts = p;
    notifyListeners();
  }

  Future getATickets() async {
    await getActiveTicketsF(user!.localId!);
    await getActiveTicketsKeysF(user!.localId!);
    notifyListeners();

    for (var i = 0; i < _activeTickets!.length; i++) {
      Product? p = await productServices.getProductById(
        _activeTickets![i].id!,
        _activeTickets![i].category,
      );
      if (int.tryParse(p!.quantity!)! <= 0) {
        await userServices.deleteActiveTicket(
            user!.localId!, _activeTicketKeys![i]);
        await getActiveTicketsF(user!.localId!);
      }
    }
  }

  Future getActiveTicketsKeysF(String uid) async {
    _activeTicketKeys = await userServices.getActiveTicketsKeys(uid);
    notifyListeners();
  }

  Future getActiveTicketsF(String uid) async {
    _activeTickets = await userServices.getActiveTickets(uid);
    notifyListeners();
  }

  Future getWinnerTicketsF(String uid) async {
    _winnerTickets = await ticketServices.getWinnerTickets(uid);
    notifyListeners();
  }

  Future emptyCart() async {
    for (var i = 0; i < getCartProducts.length; i++) {
      await addActiveTickets(
        user!.localId!,
        Product(
          img: getCartProducts[i].img,
          name: getCartProducts[i].name,
          desc: getCartProducts[i].desc,
          price: getCartProducts[i].price,
          category: getCartProducts[i].category,
          cartQty: getCartProducts[i].cartQty,
          quantity: getCartProducts[i].quantity,
          isFavorite: getCartProducts[i].isFavorite,
          id: getCartProducts[i].id!,
        ),
      );
      await productServices.updateProductById(
          getCartProducts[i].id!,
          Product(
            img: getCartProducts[i].img,
            name: getCartProducts[i].name,
            desc: getCartProducts[i].desc,
            price: getCartProducts[i].price,
            category: getCartProducts[i].category,
            quantity: (int.tryParse(getCartProducts[i].quantity!)! -
                    int.tryParse(getCartProducts[i].cartQty!)!)
                .toString(),
            isFavorite: getCartProducts[i].isFavorite,
          ),
          getCartProducts[i].category);

      await ticketServices.postTicket(
        getCartProducts[i].id!,
        user!.localId!,
        Ticket(uid: user!.localId!, count: getCartProducts[i].cartQty!),
      );
      if (int.tryParse(getCartProducts[i].quantity!)! -
              int.tryParse(getCartProducts[i].cartQty!)! ==
          0) {
        //TODO raffle
        await getTicketsF(getCartProducts[i].id!);

        for (var i = 0; i < _tickets!.length; i++) {
          for (var y = 0; y < int.tryParse(_tickets![i].count!)!; y++) {
            _uidTicketList.add(_tickets![i].uid!);
          }
        }

        var index = Random().nextInt(_uidTicketList.length);

        await ticketServices.postWinnerTicket(
            _uidTicketList[index], getCartProducts[i], getCartProducts[i].id!);
        await getWinnerTicketsF(user!.localId!);
        _uidTicketList = [];
        notifyListeners();
      }
    }
    await userServices.emptyCart(user!.localId!);
    await getCart(user!.localId!);
    notifyListeners();
  }

  Future addFavorites(String uid, String id, Product product) async {
    await userServices.addFavorites(uid, product, id);
    await getFavoritesF(uid);
    notifyListeners();
  }

  Future deleteFavorites(String uid, String id) async {
    await userServices.deleteFavorites(uid, id);
    await getFavoritesF(uid);
    notifyListeners();
  }

  Future getFavoritesF(String uid) async {
    _favorites = await userServices.getFavorites(uid);
    notifyListeners();
  }

  Future updateUserById(String uid, User u) async {
    await userServices.updateUserById(uid, u);
    user = await userServices.getUserByLocalId(user!.localId!, user!.id);
    notifyListeners();
  }

  Future getTicketsF(String productId) async {
    _tickets = await ticketServices.getTickets(productId);
    notifyListeners();
  }
}
