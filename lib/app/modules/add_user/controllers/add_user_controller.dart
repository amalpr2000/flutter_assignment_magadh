import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assignment_magadh/app/modules/login/controllers/login_controller.dart';
import 'package:flutter_assignment_magadh/utils/colors.dart';
import 'package:flutter_assignment_magadh/utils/constants.dart';
import 'package:flutter_assignment_magadh/utils/snackbar.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddUserController extends GetxController {
  final formkey1 = GlobalKey<FormState>();
  final formkey2 = GlobalKey<FormState>();
  final formkey3 = GlobalKey<FormState>();
  String imgPath = 'x';
  final namecontroller = TextEditingController();

  final phonecontroller = TextEditingController();
  final emailcontroller = TextEditingController();
  late GoogleMapController mapController;
  late LatLng markerPosition;
  Dio dio = Dio();
  createUser() async {
    try {
      final response = await dio.post(baseUrl + createNewUser,
          data: {
            "name": namecontroller.text,
            "email": emailcontroller.text,
            "phone": phonecontroller.text,
            "location": {"latitude": markerPosition.latitude, "longitude": markerPosition.longitude}
          },
          options: Options(
            headers: {"Authorization": "Bearer $token"},
          ));
      if (response.statusCode == 200 || response.statusCode == 201) {
        log('user creation successssssssssssssssssss');
        Get.back();

        customSnackbar(title: 'User', msg: 'User added successfully', barColor: snackGreen);
      }
    } catch (e) {
      print('Errrrrrrrrrrrrrorrrrrrrrrrrrrrrrrrrrrrrrrrr in user create');
      log(e.toString());
      customSnackbar(title: 'Error', msg: 'retry after sometimes', barColor: snackred);
    }
  }
}
