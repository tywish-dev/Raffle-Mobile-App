// ignore_for_file: public_member_api_docs, sort_constructors_first, unused_import, depend_on_referenced_packages
import 'dart:convert';

import 'package:collection/collection.dart';

class Product {
  String? id;
  String img;
  String name;
  String desc;
  String price;
  String category;
  String? quantity;
  String? cartQty;
  bool? isFavorite = false;
  Product({
    this.id,
    required this.img,
    required this.name,
    required this.desc,
    required this.price,
    required this.category,
    this.quantity,
    this.cartQty,
    this.isFavorite,
  });

  Product copyWith({
    String? id,
    String? img,
    String? name,
    String? desc,
    String? price,
    String? category,
    String? quantity,
    String? cartQty,
    bool? isFavorite,
  }) {
    return Product(
      id: id ?? this.id,
      img: img ?? this.img,
      name: name ?? this.name,
      desc: desc ?? this.desc,
      price: price ?? this.price,
      category: category ?? this.category,
      quantity: quantity ?? this.quantity,
      cartQty: cartQty ?? this.cartQty,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'img': img,
      'name': name,
      'desc': desc,
      'price': price,
      'category': category,
      'quantity': quantity,
      'cartQty': cartQty,
      'isFavorite': isFavorite,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] != null ? map['id'] as String : null,
      img: map['img'] as String,
      name: map['name'] as String,
      desc: map['desc'] as String,
      price: map['price'] as String,
      category: map['category'] as String,
      quantity: map['quantity'] != null ? map['quantity'] as String : null,
      cartQty: map['cartQty'] != null ? map['cartQty'] as String : null,
      isFavorite: map['isFavorite'] != null ? map['isFavorite'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Product(id: $id, img: $img, name: $name, desc: $desc, price: $price, category: $category, quantity: $quantity, cartQty: $cartQty, isFavorite: $isFavorite)';
  }

  @override
  bool operator ==(covariant Product other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.img == img &&
        other.name == name &&
        other.desc == desc &&
        other.price == price &&
        other.category == category &&
        other.quantity == quantity &&
        other.cartQty == cartQty &&
        other.isFavorite == isFavorite;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        img.hashCode ^
        name.hashCode ^
        desc.hashCode ^
        price.hashCode ^
        category.hashCode ^
        quantity.hashCode ^
        cartQty.hashCode ^
        isFavorite.hashCode;
  }
}
