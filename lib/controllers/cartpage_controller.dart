import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartPageController extends GetxController {
  // List of items in Cart
  List<String> cartItems = <String>[].obs;

  // to Add item to cart
  void addToCart(String itemName) {
    try {
      cartItems.addIf(!cartItems.contains(itemName), itemName);
    } catch (e) {
      debugPrint('Error while adding item to cart = $e');
    }
  }

  // to Remove item from cart
  void removeFromCart(int itemIndex) {
    try {
      cartItems.removeAt(itemIndex);
    } catch (e) {
      debugPrint('Error while removing item from cart = $e');
    }
  }
}
