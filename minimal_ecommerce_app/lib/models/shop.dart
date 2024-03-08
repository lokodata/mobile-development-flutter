import 'package:flutter/material.dart';
import 'package:minimal_ecommerce_app/models/product.dart';

class Shop extends ChangeNotifier {
  // products for sale
  final List<Product> _shop = [
    // product 1
    Product(
        name: "Product 1",
        price: 150.99,
        description: "Item description...",
        imagePath: "assets/product_1.jpg"),

    // product 2
    Product(
        name: "Product 2",
        price: 150.99,
        description: "Item description...",
        imagePath: "assets/product_2.jpg"),

    // product 3
    Product(
        name: "Product 3",
        price: 99.99,
        description: "Item description...",
        imagePath: "assets/product_3.jpg"),

    // product 4
    Product(
        name: "Product 4",
        price: 99.99,
        description: "Item description...",
        imagePath: "assets/product_4.png"),

    // product 5
    Product(
        name: "Product 5",
        price: 200.99,
        description: "Item description...",
        imagePath: "assets/product_6.jpg"),
  ];

  // user cart
  final List<Product> _cart = [];

  // get product list
  List<Product> get shop => _shop;

  // get user cart
  List<Product> get cart => _cart;

  // add product to cart
  void addToCart(Product item) {
    _cart.add(item);
    notifyListeners();
  }

  // remove product from cart
  void removeFromCart(Product item) {
    _cart.remove(item);
    notifyListeners();
  }
}
