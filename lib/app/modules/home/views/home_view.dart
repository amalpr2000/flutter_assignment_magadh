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
      ),
      body: FutureBuilder(
        future: controller.fetchUsers(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.separated(
              itemBuilder: ((context, index) {
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: ListTile(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    contentPadding: EdgeInsets.all(15),
                    tileColor: Colors.blueGrey[50],
                    onTap: () {
                      Get.toNamed(Routes.USER_DETAILS, arguments: index);
                    },
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(snapshot.data!.users![index].name!),
                        Text(snapshot.data!.users![index].email!),
                      ],
                    ),
                    leading: GestureDetector(
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(img + snapshot.data!.users![index].image!),
                        radius: 30,
                      ),
                    ),
                  ),
                );
              }),
              separatorBuilder: ((context, index) {
                return SizedBox(
                  height: 0,
                );
              }),
              itemCount: snapshot.data!.users!.length);
        },
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
