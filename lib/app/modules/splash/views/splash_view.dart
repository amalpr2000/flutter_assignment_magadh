import 'package:flutter/material.dart';
import 'package:flutter_assignment_magadh/utils/colors.dart';

import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    controller.checkUserLoggedIn();
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: const Center(
        child: Text(
          'Magadh Assignment',
          style: TextStyle(
            fontSize: 30,
            color: kwhite,
          ),
        ),
      ),
    );
  }
}
