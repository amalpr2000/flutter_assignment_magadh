import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_assignment_magadh/app/data/models/user_model.dart';
import 'package:flutter_assignment_magadh/app/modules/login/controllers/login_controller.dart';
import 'package:flutter_assignment_magadh/utils/constants.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  Dio dio = Dio();
  Map<String, dynamic> userData = {};
  // String token = "";
  Future<UserModel?> fetchUsers() async {
    log('heloooooooooooooooooooooooooooo');

    try {
      final response = await dio.get(baseUrl + allUsers,
          options: Options(
            headers: {"Authorization": "Bearer $token"},
          ));
      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data);
      }
    } catch (e) {
      print('Errrrrrrrrrrrrrorrrrrrrrrrrrrrrrrrrrrrrrrrr OTP');
      log(e.toString());
    }
    return null;
  }
}
