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
            enableDrag: true,
            ignoreSafeArea: false,
            isScrollControlled: true,
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  fit: FlexFit.loose,
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 70),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                                  fit: FlexFit.loose,
                                  child: Text("Filter by Price")),
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
                          const SizedBox(height: 20),
                          Obx(
                            () => Text(homePageController.selectedPrice.value),
                          ),
                          // Filter by Category UI

                          const Divider(),
                          const SizedBox(height: 20),
                          const Row(
                            children: [
                              Flexible(
                                  fit: FlexFit.loose,
                                  child: Text("Filter by Category")),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Obx(
                            () {
                              return DropdownMenu(
                                initialSelection:
                                    homePageController.selectedValue.value,
                                dropdownMenuEntries: homePageController.itemList
                                    .map<DropdownMenuEntry<String>>(
                                        (String value) {
                                  return DropdownMenuEntry<String>(
                                      value: value, label: value);
                                }).toList(),
                                onSelected: (value) {
                                  homePageController.selectedValue.value =
                                      value!;
                                  // fetching data by category
                                  homePageController
                                      .fetchProductsByCategoryAndPrice(
                                          homePageController
                                              .selectedValue.value,
                                          homePageController
                                              .selectedPrice.value);
                                },
                              );
                            },
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            child: ElevatedButton(
                              onPressed: () {
                                homePageController.selectedValue.value = '';
                                // fetching data by category
                                homePageController
                                    .fetchProductsByCategoryAndPrice(
                                        homePageController.selectedValue.value,
                                        homePageController.selectedPrice.value);
                              },
                              child: const Text('Clear'),
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Divider(),
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              OutlinedButton(
                                onPressed: Get.back,
                                child: const Text("Close"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        icon: const Icon(Icons.filter_alt_outlined),
      ),
    ],
  );
}
