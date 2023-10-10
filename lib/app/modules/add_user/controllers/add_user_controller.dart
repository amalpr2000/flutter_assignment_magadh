import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assignment_magadh/app/modules/login/controllers/login_controller.dart';
import 'package:flutter_assignment_magadh/utils/constants.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

class AddUserController extends GetxController {
  //TODO: Implement AddUserController

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
      }
    } catch (e) {
      print('Errrrrrrrrrrrrrorrrrrrrrrrrrrrrrrrrrrrrrrrr in user create');
      log(e.toString());
    }
  }

  Future<void> pickPhotoFromGallery() async {
    final PickedImg = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (PickedImg != null) {
      imgPath = PickedImg.path;
    }
    update();
  }
}
