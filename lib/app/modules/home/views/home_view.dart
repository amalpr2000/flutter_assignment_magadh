import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_assignment_magadh/app/routes/app_pages.dart';
import 'package:flutter_assignment_magadh/utils/colors.dart';

import 'package:flutter_assignment_magadh/utils/constants.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Get.toNamed(Routes.PROFILE);
              },
              icon: Icon(Icons.person)),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              height: 50,
              child: TextField(
                controller: controller.searchCtr,
                decoration: InputDecoration(
                  suffixIcon: InkWell(
                      onTap: () {
                        controller.searchCtr.clear();
                        controller.query.value = '';
                      },
                      child: Obx(
                        () => controller.isSearchSelected.value
                            ? Icon(Icons.clear)
                            : Icon(Icons.search),
                      )),
            
                  filled: true,
                  fillColor: Color.fromARGB(255, 242, 243, 245),
                  contentPadding: const EdgeInsets.all(20),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.white, width: 0.0),
                  ),
                  labelText: 'Try search here',
                  labelStyle: const TextStyle(color: kSecondaryColor),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onChanged: (value) {
                  controller.query.value = value;
                },
              ),
            ),
          ),
          Expanded(
            child: Obx(
              () =>
                  RefreshIndicator(
                      onRefresh: () {
                        controller.userList.clear();
                        controller.page.value = 1;
                        return controller.fetchUsers();
                      },
                      child: controller.userList.length != 0
                          ? ListView.separated(
                              physics: BouncingScrollPhysics(),
                              controller: controller.scrollController,
                              padding: EdgeInsets.all(10),
                              itemCount: controller.userList.length + 1 ?? 0,
                              itemBuilder: ((context, index) {
                                if (controller.count == index) {
                                  return SizedBox.shrink();
                                }
                                if (index == controller.userList.length) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                return ListTile(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  contentPadding: EdgeInsets.all(15),
                                  tileColor: Colors.blueGrey[50],
                                  onTap: () {
                                    Get.toNamed(Routes.USER_DETAILS,
                                        arguments: controller.userList[index]);
                                  },
                                  title: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text((controller.userList[index].name) ?? ''),
                                      Text(controller.userList[index].email ?? ''),
                                    ],
                                  ),
                                  leading: GestureDetector(
                                    child: CircleAvatar(
                                      backgroundImage: NetworkImage(controller
                                                  .userList[index].image !=
                                              null
                                          ? (img + controller.userList[index].image!)
                                          : 'https://edug.in/panel/head_admin/School/school_head/first_photo/DEMO59167.jpg'),
                                      radius: 30,
                                    ),
                                  ),
                                );
                              }),
                              separatorBuilder: ((context, index) {
                                return SizedBox(
                                  height: 10,
                                );
                              }),
                            )
                          : Center(
                              child: Text('No user found'),
                            )),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(
            Routes.ADD_USER,
          );
        },
        child: Icon(Icons.person_add_alt_1),
      ),
    );
  }
}
