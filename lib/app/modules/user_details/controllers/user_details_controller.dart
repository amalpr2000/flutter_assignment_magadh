import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_assignment_magadh/app/data/models/user_model.dart';
import 'package:flutter_assignment_magadh/utils/constants.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../login/controllers/login_controller.dart';

class UserDetailsController extends GetxController {
  //TODO: Implement UserDetailsController

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
  late GoogleMapController mapController;
  late LatLng markerPosition;

  Users user = Get.arguments;

  createUpdate() async {
    Dio dio = Dio();
    try {
      final response = await dio.patch(baseUrl + createNewUser,
          data: {"image": 'qwertyui', "location": '{"location":{"latitude":220,"longitude":320}}'},
          options: Options(
            headers: {"Authorization": "Bearer $token"},
          ));
      log('statussssssssssssssssssss codeeeeeeeee');
      log(response.statusCode.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        log('user updateddddd successssssssssssssssssss');
      }
    } catch (e) {
      print('Errrrrrrrrrrrrrorrrrrrrrrrrrrrrrrrrrrrrrrrr in user update');
      log(e.toString());
    }
  }
}
