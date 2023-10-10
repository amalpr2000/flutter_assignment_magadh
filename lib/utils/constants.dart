import 'package:flutter/material.dart';

const String baseUrl = 'https://flutter.magadh.co/api/v1';
const String login = '/users/login-request';
const String loginVerify = '/users/login-verify';
const String verifyToken = '/users/verify-token';
const String allUsers = '/users';
const String createNewUser = '/users';
const String updateProfile = '/users';
const String img = 'https://flutter.magadh.co/';

SizedBox kHeight10 = const SizedBox(height: 10);
SizedBox kHeight20 = const SizedBox(height: 20);
SizedBox kHeight40 = const SizedBox(height: 40);
sizedboxwithheight(double? height) {
  return SizedBox(
    height: height,
  );
}
