import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_assignment_magadh/app/data/models/user_model.dart';
import 'package:flutter_assignment_magadh/app/modules/login/controllers/login_controller.dart';
import 'package:flutter_assignment_magadh/utils/constants.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
    ever(page, (callback) {
      if (callback != 0) fetchUsers();
    });
    debounce(query, (callback) {
      fetchUsers();
    }, time: Duration(milliseconds: 500));
    scrollController.addListener(() {
      log('Add Listener');
      if (isLoading.value) {
        return;
      }
      if (isTouchingBottom) page.value++;
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  RxString query = ''.obs;
  int count = 0;
  RxBool isLoading = false.obs;
  Dio dio = Dio();
  Map<String, dynamic> userData = {};
  // String token = "";
  // UserModel userModelObj = UserModel();
  RxList<Users> userList = <Users>[].obs;
  RxInt page = 1.obs;
  ScrollController scrollController = ScrollController();
  bool get isTouchingBottom {
    log('touching bottom');
    return scrollController.position.pixels == scrollController.position.maxScrollExtent;
  }

  Future<void> fetchUsers() async {
    try {
      isLoading.value = true;
      final response = await dio.get(baseUrl + allUsers,
          queryParameters: {'limit': '20', 'page': '${page.value}', 'search': query.value},
          options: Options(
            headers: {"Authorization": "Bearer $token"},
          ));
      if (response.statusCode == 200) {
        // userModelObj = UserModel.fromJson(response.data);
        count = response.data['count'];
        userList.addAll((response.data['users'] as List).map((e) => Users.fromJson(e)));
      }
    } catch (e) {
      log('Error fetchUsers : $e');
    } finally {
      isLoading.value = false;
    }
  }
}
