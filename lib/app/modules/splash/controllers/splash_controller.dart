import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_assignment_magadh/app/modules/login/controllers/login_controller.dart';
import 'package:flutter_assignment_magadh/app/routes/app_pages.dart';
import 'package:flutter_assignment_magadh/utils/constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController {
  //TODO: Implement SplashController

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> goToLogin() async {
    await Future.delayed(Duration(seconds: 1));
    Get.offAllNamed(Routes.LOGIN);
  }

  Future<void> checkUserLoggedIn() async {
    final _sharedPrefs = await SharedPreferences.getInstance();
    final String? tokenSaved = _sharedPrefs.getString('tokenSaved');

    if (tokenSaved == null || tokenSaved == 'notverified') {
      goToLogin();
    } else {
      token = tokenSaved;
      await Future.delayed(Duration(seconds: 1));
      Get.offAllNamed(Routes.HOME);
    }
  }

  
}
