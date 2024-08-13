import 'package:filter_ui/Pages/cartpage.dart';
import 'package:filter_ui/controllers/cartpage_controller.dart';
import 'package:filter_ui/controllers/homepage_controller.dart';
import 'package:filter_ui/widgets/appbarwidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Homepage extends StatelessWidget {
  Homepage({super.key});
  final HomePageController homePageController = Get.put(HomePageController());
  final CartPageController cartPageController = Get.put(CartPageController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(context),
      body: SafeArea(
        child: Obx(
          () => homePageController.products.isEmpty
              ? Container(
                  alignment: Alignment.topCenter,
                  child: const Text('Nothing to show !'))
              : ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: homePageController.products.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        '${homePageController.products[index]['itemname']}',
                      ),
                      subtitle: Text(
                        '${homePageController.products[index]['itemprice']} Rupee',
                      ),
                      trailing: ElevatedButton(
                        onPressed: () {
                          cartPageController.addToCart({
                            'itemname': homePageController.products[index]
                                ['itemname'],
                            'itemprice': homePageController.products[index]
                                ['itemprice'],
                            'itemcount': 1
                          });
                          Get.to(() => CartPage());
                        },
                        child: const Text('Add to Cart'),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
