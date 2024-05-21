import 'package:flutter/material.dart';
import 'package:the_jorden_sneakers/models/product.dart';


class CartModel extends ChangeNotifier{
  final List<Product> _cartItems = [];

  List<Product> get cartItems => _cartItems;

  void addToCart(Product product){
    _cartItems.add(product);
    notifyListeners(); //Notify listeners of state change

  }

  void removeFromCart(Product product){
    _cartItems.remove(product);
    notifyListeners(); //Notify listeners of state change
  }
}