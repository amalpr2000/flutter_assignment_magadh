import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_assignment_magadh/app/data/models/user_model.dart';
import 'package:flutter_assignment_magadh/app/modules/login/controllers/login_controller.dart';
import 'package:flutter_assignment_magadh/app/routes/app_pages.dart';
import 'package:flutter_assignment_magadh/utils/colors.dart';
import 'package:flutter_assignment_magadh/utils/constants.dart';
import 'package:flutter_assignment_magadh/utils/snackbar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
    ever(page, (callback) {
      if (callback != 1) fetchUsers();
    });
    debounce(query, (callback) {
      userList.clear();
      page.value = 1;
      fetchUsers();
    }, time: Duration(milliseconds: 500));
    scrollController.addListener(() {
      if (isLoading.value) {
        log('Add Listener');
        return;
      }
      if (isTouchingBottom) {
        page.value++;
        log('Touch');
      }
    });
    searchCtr.addListener(() {
      if (searchCtr.text.isNotEmpty) {
        isSearchSelected.value = true;
      } else {
        isSearchSelected.value = false;
      }
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  RxBool isSearchSelected = false.obs;
  RxString query = ''.obs;
  TextEditingController searchCtr = TextEditingController();
  int count = 0;
  RxBool isLoading = false.obs;
  Dio dio = Dio();
  RxList<Users> userList = <Users>[].obs;
  RxInt page = 1.obs;
  ScrollController scrollController = ScrollController();
  bool get isTouchingBottom {
    return scrollController.position.pixels == scrollController.position.maxScrollExtent;
  }

  Future<void> fetchUsers() async {
    try {
      log('token from home =========> $token');
      isLoading.value = true;

      final response = await dio.get(baseUrl + allUsers,
          queryParameters: {'limit': '15', 'page': '${page.value}', 'search': query.value},
          options: Options(
            headers: {"Authorization": "Bearer $token"},
          ));

      log('======>>>>${response.statusCode}');

      if (response.statusCode == 200) {
        count = response.data['count'];
        userList.addAll((response.data['users'] as List).map((e) => Users.fromJson(e)));
      }
    } catch (e) {
      log('Error fetchUsers : $e');
      print(e.toString());
      if (e.toString() ==
          ' DioException [bad response]: The request returned an invalid status code of 401.') {
        customSnackbar(title: 'Login Expired', msg: 'logging out', barColor: snackred);
        await Future.delayed(Duration(seconds: 2));
        final _sharedPrefs = await SharedPreferences.getInstance();
        await _sharedPrefs.clear();
        Get.offAllNamed(Routes.LOGIN);
      }
      customSnackbar(title: 'Error', msg: '${e.toString()}', barColor: snackred);
    } finally {
      isLoading.value = false;
    }
  }
  
}
