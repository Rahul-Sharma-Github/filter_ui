import 'package:filter_ui/controllers/homepage_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

PreferredSizeWidget appBarWidget(BuildContext context) {
  final HomePageController homePageController = Get.put(HomePageController());
  final List<String> choices = ['50', '60', '90', '120'];

  return AppBar(
    centerTitle: true,
    title: const Text('Filter Demo'),
    actions: [
      IconButton.outlined(
        onPressed: () {
          Get.bottomSheet(
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                            fit: FlexFit.loose,
                            child: Text("Filter Menu Items")),
                      ],
                    ),
                    const Divider(),
                    const SizedBox(height: 20),
                    const Row(
                      children: [
                        Flexible(
                            fit: FlexFit.loose, child: Text("Filter by Price")),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Flexible(
                          fit: FlexFit.loose,
                          child: Obx(
                            () => Wrap(
                              spacing: 8.0,
                              children: List<Widget>.generate(
                                choices.length,
                                (int index) {
                                  return ChoiceChip(
                                    label: Text(choices[index]),
                                    selected: homePageController
                                            .selectedChoiceIndex.value ==
                                        index,
                                    onSelected: (bool selected) {
                                      homePageController.selectChoice(
                                          index, choices);
                                    },
                                  );
                                },
                              ).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    const SizedBox(height: 20),
                    Obx(
                      () => Text(homePageController.selectedPrice.value),
                    ),
                    const Spacer(),
                    OutlinedButton(
                      onPressed: Get.back,
                      child: const Text("Close"),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        icon: const Icon(Icons.filter_alt_outlined),
      ),
    ],
  );
}
