import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assignment_magadh/app/routes/app_pages.dart';
import 'package:flutter_assignment_magadh/utils/colors.dart';
import 'package:flutter_assignment_magadh/utils/constants.dart';
import 'package:flutter_assignment_magadh/utils/snackbar.dart';
import 'package:get/get.dart';

String token = '';

class LoginController extends GetxController {
  String otp = '';
  final TextEditingController phoneNumberController =
      TextEditingController(text: kDebugMode ? '7025307719' : null);
  // Map<String, dynamic> map = {};
  TextEditingController otpController = TextEditingController();
  RxBool isVisible = true.obs;
  Dio dio = Dio();
  final formkeyPhone = GlobalKey<FormState>();
  final formkeyOtp = GlobalKey<FormState>();

  verifyNumber() async {
    try {
      final response = await dio.post(baseUrl + login, data: {"phone": phoneNumberController.text});
      if (response.statusCode == 200 || response.statusCode == 201) {
        isVisible.value = false;
      }

      // map = Map<String, dynamic>.from(response.data);
      log(response.statusCode.toString());
      log(response.data.toString());
      otp = response.data['otp'].toString();
    } catch (e) {
     log('Error verifyNumber : $e');
    }
  }

  verifyOtp() async {
    try {
      final response = await dio
          .post(baseUrl + loginVerify, data: {"phone": phoneNumberController.text, "otp": otp});
      if (response.statusCode == 200 || response.statusCode == 201) {
        // var map = Map<String, dynamic>.from(response.data);
        token = response.data['token'].toString();

        print('tokeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeen');
        log(token);
        // print(map["token"]);
        // token = map["token"];
      }
    } catch (e) {
      print(' OTP not verified');
      log(e.toString());
    } finally {
      tokenVerification();
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
        customSnackbar(title: 'Login', msg: 'Login Success', barColor: snackGreen);
        Get.offAndToNamed(Routes.HOME);
      }
    } catch (e) {
      log('Error tokenVerification : $e');
    }
  }
}
