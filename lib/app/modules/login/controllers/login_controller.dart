import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assignment_magadh/app/routes/app_pages.dart';
import 'package:flutter_assignment_magadh/utils/colors.dart';
import 'package:flutter_assignment_magadh/utils/constants.dart';
import 'package:flutter_assignment_magadh/utils/snackbar.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

String token = '';

class LoginController extends GetxController {
  final TextEditingController phoneNumberController =
      TextEditingController(text: kDebugMode ? '7025307719' : null);

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

      log(response.statusCode.toString());
      log(response.data.toString());
      otpController.text = response.data['otp'].toString();
    } catch (e) {
      log('Error verifyNumber : $e');
      customSnackbar(title: 'Invalid number', msg: 'Please enter valid number', barColor: snackred);
    }
  }

  verifyOtp() async {
    try {
      final response = await dio.post(baseUrl + loginVerify,
          data: {"phone": phoneNumberController.text, "otp": otpController.text});
      if (response.statusCode == 200 || response.statusCode == 201) {
        token = response.data['token'].toString();
        tokenVerification();

        print('otp verified');
        log(token);
      }
    } catch (e) {
      print(' OTP not verified');
      customSnackbar(title: 'OTP not verified', msg: 'Enter a valid OTP', barColor: snackred);
      log(e.toString());
    } finally {}
  }

  tokenVerification() async {
    try {
      final response = await dio.get(baseUrl + verifyToken,
          options: Options(
            headers: {"Authorization": "Bearer $token"},
          ));
      if (response.statusCode == 200) {
        log('Token Verifieddddddddddddddddddddddd');
        final _sharedPrefs = await SharedPreferences.getInstance();
        await _sharedPrefs.setString('tokenSaved', '$token');
        customSnackbar(title: 'Login', msg: 'Login Success', barColor: snackGreen);
        Get.offAndToNamed(Routes.HOME);
      }
    } catch (e) {
      final _sharedPrefs = await SharedPreferences.getInstance();
      await _sharedPrefs.setString('tokenSaved', 'notverified');

      log('Error tokenVerification : $e');
    }
  }
}
