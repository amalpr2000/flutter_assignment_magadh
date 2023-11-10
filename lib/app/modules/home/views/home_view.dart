import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_assignment_magadh/app/routes/app_pages.dart';

import 'package:flutter_assignment_magadh/utils/constants.dart';

import 'package:get/get.dart';

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
                Get.toNamed(Routes.SEARCH_USER);
              },
              icon: Icon(Icons.search))
        ],
      ),
      body: Column(
        children: [
          TextField(
            onChanged: (value) {
              controller.query.value = value;
            },
          ),
          Expanded(
            child: Obx(
              () =>
                  // controller.isLoading.value
                  //     ? Center(
                  //         child: CircularProgressIndicator(),
                  //       )
                  //     :
                  ListView.separated(
                      controller: controller.scrollController,
                      padding: EdgeInsets.all(10),
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
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          contentPadding: EdgeInsets.all(15),
                          tileColor: Colors.blueGrey[50],
                          onTap: () {
                            Get.toNamed(Routes.USER_DETAILS, arguments: controller.userList[index]);
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
                              backgroundImage: NetworkImage(controller.userList[index].image != null
                                  ? (img + controller.userList[index].image!)
                                  : 'https://edug.in/panel/head_admin/School/school_head/first_photo/DEMO59167.jpg'),
                              radius: 30,
                            ),
                          ),
                        );
                      }),
                      separatorBuilder: ((context, index) {
                        return SizedBox(
                          height: 0,
                        );
                      }),
                      itemCount: controller.userList.length + 1 ?? 0),
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
