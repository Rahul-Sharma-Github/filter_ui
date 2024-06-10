import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;

class HomePageController extends GetxController {
  List<dynamic> products = [].obs;
  // Fetching data on initialization
  @override
  Future<void> onInit() async {
    super.onInit();
    // Fetching for first time while initializing
    await fetchProductsByPrice('');
  }

  // Method to fetch Data
  Future<void> fetchProductsByPrice(String price) async {
    try {
      if (price.isEmpty) {
        final response =
            await http.get(Uri.parse('http://10.0.2.2:3000/all-menu-items'));

        if (response.statusCode == 200) {
          products.assignAll(await json.decode(response.body));
          Get.snackbar('Successfull', 'Data Fetched !');
        } else {
          Get.snackbar('Error', 'Error while Fetching !');
        }
      } else {
        final response = await http
            .get(Uri.parse('http://10.0.2.2:3000/menu-items-by-price/$price'));

        if (response.statusCode == 200) {
          products.assignAll(await json.decode(response.body));
          Get.snackbar('Successfull', 'Data Fetched !');
        } else {
          Get.snackbar('Error', 'Error while Fetching !');
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

  //
  void selectChoice(int index, List<String> choices) async {
    if (selectedChoiceIndex.value == index) {
      // if choice chip already selected, then unselect it
      selectedChoiceIndex.value = -1;
      // clearing selectedPrice value
      selectedPrice.value = '';
      await fetchProductsByPrice('');
      debugPrint('Before change = ${products.length}');
    } else {
      // if choice chip is not selected, then select it, and unselect all other choice chips
      selectedChoiceIndex.value = index;
      // store selected choice's string to a variable
      selectedPrice.value = choices[index];
      await fetchProductsByPrice(choices[index]);
      debugPrint('After change = ${products.length}');
    }
  }
}
