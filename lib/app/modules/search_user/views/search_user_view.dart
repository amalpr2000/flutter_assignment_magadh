import 'package:flutter/material.dart';
import 'package:flutter_assignment_magadh/utils/colors.dart';

import 'package:get/get.dart';

import '../controllers/search_user_controller.dart';

class SearchUserView extends GetView<SearchUserController> {
  const SearchUserView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SearchUser'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(
              height: Get.width * .035,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(Icons.arrow_back)),
                Spacer(),
                SizedBox(
                  height: 50,
                  width: Get.width * .75,
                  child: Material(
                    elevation: 10,
                    borderRadius: BorderRadius.circular(12),
                    child: TextFormField(
                      onChanged: (value) {
                        // searchText.search(value);
                      },
                      controller: controller.searchController,
                      autofocus: true,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search_rounded),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.all(20),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.white, width: 0.0),
                        ),
                        labelText: 'Try search here',
                        labelStyle: const TextStyle(color: kSecondaryColor),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: Get.width * 0.06,
                )
              ],
            ),
            SizedBox(
              height: Get.width * .05,
            ),
            // GetBuilder(
            //     init: controller,
            //     builder: (controller) => controller.searchList.isNotEmpty
            //         ? SearchFound(searchText: searchText)
            //         : SearchNotFound(displayHeight: displayHeight))
          ],
        ),
      ),
    );
  }
}
