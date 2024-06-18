import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;

class HomePageController extends GetxController {
  // List of Fetched Products
  List<dynamic> products = [].obs;

  // Fetching data on initialization
  @override
  Future<void> onInit() async {
    super.onInit();
    // Fetching for first time while initializing
    await fetchProductsByCategoryAndPrice('', '');
  }

  // Method to fetch Data by Price
  Future<void> fetchProductsByCategoryAndPrice(
      String category, String price) async {
    try {
      if (price.isEmpty && category.isEmpty) {
        final response =
            await http.get(Uri.parse('http://10.0.2.2:3000/all-menu-items'));

        if (response.statusCode == 200) {
          products.assignAll(await json.decode(response.body));
          Get.snackbar('Successful', 'Data Fetched !',
              animationDuration: const Duration(milliseconds: 100),
              duration: const Duration(milliseconds: 1000));
        } else {
          Get.snackbar('Error', 'Error while Fetching !',
              animationDuration: const Duration(milliseconds: 100),
              duration: const Duration(milliseconds: 1000));
        }
      } else if (category.isNotEmpty && price.isNotEmpty) {
        final response = await http.get(Uri.parse(
            'http://10.0.2.2:3000/menu-items-by-price-category/$category&$price'));

        if (response.statusCode == 200) {
          products.assignAll(await json.decode(response.body));
          Get.snackbar('Successful', 'Data Fetched !',
              animationDuration: const Duration(milliseconds: 100),
              duration: const Duration(milliseconds: 1000));
        } else {
          Get.snackbar('Error', 'Error while Fetching !',
              animationDuration: const Duration(milliseconds: 100),
              duration: const Duration(milliseconds: 1000));
        }
      } else if (price.isNotEmpty) {
        final response = await http
            .get(Uri.parse('http://10.0.2.2:3000/menu-items-by-price/$price'));

        if (response.statusCode == 200) {
          products.assignAll(await json.decode(response.body));
          Get.snackbar('Successful', 'Data Fetched !',
              animationDuration: const Duration(milliseconds: 100),
              duration: const Duration(milliseconds: 1000));
        } else {
          Get.snackbar('Error', 'Error while Fetching !',
              animationDuration: const Duration(milliseconds: 100),
              duration: const Duration(milliseconds: 1000));
        }
      } else if (category.isNotEmpty) {
        final response = await http
            .get(Uri.parse('http://10.0.2.2:3000/menu-items/$category'));

        if (response.statusCode == 200) {
          products.assignAll(await json.decode(response.body));
          Get.snackbar('Successful', 'Data Fetched !',
              animationDuration: const Duration(milliseconds: 100),
              duration: const Duration(milliseconds: 1000));
        } else {
          Get.snackbar('Error', 'Error while Fetching !',
              animationDuration: const Duration(milliseconds: 100),
              duration: const Duration(milliseconds: 1000));
        }
      }
    } catch (e) {
      debugPrint('Error while fetching Products ! = $e');
    }
  }

// Selecting / Rejecting choice chips | also updating selected choice chip's Price

  // represents selected choice's index
  var selectedChoiceIndex = (-1).obs;
  // to store selected choice's Price
  var selectedPrice = ('').obs;

  // method to select / unselect Choice Chip
  void selectChoice(int index, List<String> choices) async {
    if (selectedChoiceIndex.value == index) {
      // if choice chip already selected, then unselect it
      selectedChoiceIndex.value = -1;
      // clearing selectedPrice value
      selectedPrice.value = '';
      await fetchProductsByCategoryAndPrice(
          selectedValue.value, selectedPrice.value);
      debugPrint('Before change = ${products.length}');
    } else {
      // if choice chip is not selected, then select it, and unselect all other choice chips
      selectedChoiceIndex.value = index;
      // store selected choice's string to a variable
      selectedPrice.value = choices[index];
      await fetchProductsByCategoryAndPrice(
          selectedValue.value, selectedPrice.value);
      debugPrint('After change = ${products.length}');
    }
  }

  //////////////////////////////

  // variable tp store selected Menu Item
  var selectedValue = ''.obs;
  var itemList = [
    'Salad',
    'Chinese',
    'Jums',
    'Wraps',
    'Toasts',
    'Pastas',
    'Rice',
    'Fries',
    'Maggi',
    'Pizza 7Inch',
    'Pizza 10Inch',
    'Burger',
    'Deserts',
    'Meals',
    'Hot Baverages',
    'coolers',
    'Dips'
  ].obs;
}
