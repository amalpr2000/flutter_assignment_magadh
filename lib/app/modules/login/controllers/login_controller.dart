import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assignment_magadh/app/routes/app_pages.dart';
import 'package:flutter_assignment_magadh/utils/constants.dart';
import 'package:get/get.dart';

String token = '';

class LoginController extends GetxController {
  final TextEditingController phoneNumberController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  Map<String, dynamic> map = {};
  RxBool isVisible = true.obs;
  Dio dio = Dio();

  verifyNumber() async {
    try {
      final response = await dio.post(baseUrl + login, data: {"phone": phoneNumberController.text});
      if (response.statusCode == 200 || response.statusCode == 201) {
        isVisible.value = false;
      }

      map = Map<String, dynamic>.from(response.data);

      log(response.data);
    } catch (e) {
      print('Errrrrrrrooooooorrrrrrrrrrrrrrrrrrrrrrrrrrr');
      log('$e');
    }
  }

  verifyOtp() async {
    try {
      final response = await dio.post(baseUrl + loginVerify,
          data: {"phone": phoneNumberController.text, "otp": otpController.text});
      if (response.statusCode == 200 || response.statusCode == 201) {
        var map = Map<String, dynamic>.from(response.data);
        print('tokeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeen in map');
        print(map["token"]);
        token = map["token"];
        tokenVerification();
      }
    } catch (e) {
      print('Errrrrrrrrrrrrrorrrrrrrrrrrrrrrrrrrrrrrrrrr OTP');
      log(e.toString());
    }
  }

  tokenVerification() async {
    try {
      final response = await dio.get(baseUrl + verifyToken,
          options: Options(
            headers: {"Authorization": "Bearer $token"},
          ));
      if (response.statusCode == 200) {
        log('Token Verifieddddddddddddddddddddddd');
        Get.offAndToNamed(Routes.HOME);
      }
    } catch (e) {}
  }
}