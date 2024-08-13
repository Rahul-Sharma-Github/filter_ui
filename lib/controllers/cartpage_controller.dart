import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartPageController extends GetxController {
  // List of items in Cart
  List<Map> cartItems = [{}].obs;

  // to Add item to cart
  void addToCart(Map data) {
    try {
      // cartItems.addIf(!cartItems.contains(data), data);
      cartItems.add(data);
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
