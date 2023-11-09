import 'dart:developer';

import 'package:dio/dio.dart';
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

  createUpdate() async {
    Dio dio = Dio();
    try {
      // final response = await dio.post(baseUrl + createNewUser,
      //     data: {
      //       "name": namecontroller.text,
      //       "email": emailcontroller.text,
      //       "phone": phonecontroller.text,
      //       "location": {"latitude": markerPosition.latitude, "longitude": markerPosition.longitude}
      //     },
      //     options: Options(
      //       headers: {"Authorization": "Bearer $token"},
      //     ));
      final response = await dio.patch(baseUrl + createNewUser,
          data: {"image": 'qwertyui', "location": '{"location":{"latitude":220,"longitude":320}}'},
          options: Options(
            headers: {"Authorization": "Bearer $token"},
          ));
      log('statussssssssssssssssssss codeeeeeeeee');
      log(response.statusCode.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        log('user updateddddd successssssssssssssssssss');
        // Get.back();

        // customSnackbar(title: 'User', msg: 'User added successfully', barColor: snackGreen);
      }
    } catch (e) {
      print('Errrrrrrrrrrrrrorrrrrrrrrrrrrrrrrrrrrrrrrrr in user update');
      log(e.toString());
      // customSnackbar(title: 'Error', msg: 'retry after sometimes', barColor: snackred);
    }
  }
}
