import 'package:flutter/material.dart';
import 'package:flutter_assignment_magadh/utils/colors.dart';
import 'package:get/get.dart';

SnackbarController customSnackbar(
    {required String title, required String msg, required Color barColor, var position}) {
  SnackPosition pos = position ?? SnackPosition.TOP;
  if (Get.isSnackbarOpen) {
    Get.closeCurrentSnackbar();
  }
  return Get.snackbar(title, msg,
      snackPosition: pos,
      margin: EdgeInsets.all(22),
      backgroundColor: barColor,
      duration: Duration(seconds: 2),
      colorText: Colors.white,
      padding: EdgeInsets.all(10));
}
