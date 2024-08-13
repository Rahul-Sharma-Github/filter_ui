import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/cartpage_controller.dart';

class CartPage extends StatelessWidget {
  CartPage({super.key});

  final CartPageController cartPageController = Get.put(CartPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Cart'),
      ),
      body: Obx(
        () => cartPageController.cartItems.isEmpty
            ? Container(
                alignment: Alignment.topCenter,
                child: const Text('Nothing to show !'))
            : ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: cartPageController.cartItems.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                        '${cartPageController.cartItems[index]['itemname']}'),
                    subtitle: Text(
                        '${cartPageController.cartItems[index]['itemprice]']}'),
                    trailing: ElevatedButton(
                      onPressed: () {
                        cartPageController.removeFromCart(index);
                        Get.back();
                      },
                      child: const Text('Remove'),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
