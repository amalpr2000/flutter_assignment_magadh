import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/src/form_data.dart' as dio_form;
import 'package:dio/src/multipart_file.dart' as dio_multi;
import 'package:flutter/material.dart';
import 'package:flutter_assignment_magadh/app/data/models/user_model.dart';
import 'package:flutter_assignment_magadh/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_assignment_magadh/app/modules/login/controllers/login_controller.dart';
import 'package:flutter_assignment_magadh/app/routes/app_pages.dart';
import 'package:flutter_assignment_magadh/utils/colors.dart';
import 'package:flutter_assignment_magadh/utils/constants.dart';
import 'package:flutter_assignment_magadh/utils/snackbar.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  final HomeController homeController = Get.find<HomeController>();

  //TODO: Implement ProfileController

  @override
  void onInit() async {
    super.onInit();
    getSelfDetails();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  String imgPath = 'x';
  String localPath = '';
  double lat = 0;
  double long = 0;
  File? imageFile;
  RxBool isLoading = false.obs;
  Users user = Users();
  LatLng markerPosition = LatLng(28.6139, 77.2090);
  RxBool isLoc = false.obs;
  TextEditingController nameCtr = TextEditingController();
  TextEditingController emailCtr = TextEditingController();
  TextEditingController phoneCtr = TextEditingController();

  getSelfDetails() async {
    isLoading.value = true;
    try {
      final response = await dio.get(baseUrl + verifyToken,
          options: Options(
            headers: {"Authorization": "Bearer $token"},
          ));
      if (response.statusCode == 200) {
        log('Profile Verifieddddddddddddddddddddddd');
        user = Users.fromJson(response.data['user']);
        nameCtr.text = user.name!;
        emailCtr.text = user.email!;
        phoneCtr.text = user.phone!;
        lat = user.location!.latitude ?? 0;
        long = user.location!.longitude ?? 0;
        markerPosition = LatLng(lat, long);
        if (user.image != null) {
          imgPath = user.image!;
        }
      }
    } catch (e) {
      log('Error Getself : $e');
      customSnackbar(title: 'Login Expired', msg: 'logging out', barColor: snackred);
      await Future.delayed(Duration(seconds: 2));
      final _sharedPrefs = await SharedPreferences.getInstance();
      await _sharedPrefs.clear();
      Get.offAllNamed(Routes.LOGIN);
    } finally {
      isLoading.value = false;
    }
  }

  late GoogleMapController mapController;
  signOut() async {
    final _sharedPrefs = await SharedPreferences.getInstance();
    await _sharedPrefs.clear();
    customSnackbar(title: 'Logout', msg: 'User logged out ', barColor: snackred);
    Get.offAllNamed(Routes.LOGIN);
  }

  imgUpdate() async {
    imageFile = null;
    final pickedImg = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImg != null) {
      localPath = pickedImg.path;
      imgPath = 'xx';
    }
    update();
    compressedImage(pickedImg!);
  }

  Future<void> compressedImage(XFile img) async {
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    final compressedImage =
        await FlutterImageCompress.compressAndGetFile(img.path, '$path/newImage.jpg', quality: 25);
    imageFile = File(compressedImage!.path);
    print('Image file issssssssssssssss');
    print(imageFile);
    print('Image path issssssssssssssss');
    log(imageFile!.path.toString());
  }

  Dio dio = Dio();
  RxBool isUpdating = false.obs;
  updateProfileInfo() async {
    if (nameCtr.text == null || nameCtr.text.trim().isEmpty) {
      return 'Enter the phone Number';
    }
    if (!RegExp(r"^[0-9]{10}$").hasMatch(phoneCtr.text)) {
      customSnackbar(
          title: 'Format incorrect', msg: 'Enter a valid phone number', barColor: snackred);
      return 'Invalid phone number format';
    }
    if (!RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(emailCtr.text)) {
      customSnackbar(title: 'Format incorrect', msg: 'Enter a valid E-mail', barColor: snackred);
      return 'Enter a valid E-mail';
    }
    log('=======>>>>>>>> Entered updateProfile');
    log('${imageFile?.path}');

    Map<String, dynamic> data = {};
    if (imageFile?.path == null) {
      log('snck bar');
      // return customSnackbar(title: 'No image', msg: 'Select image', barColor: snackred);
      return customSnackbar(title: 'No image', msg: 'Select image', barColor: snackred);
    }
    // data['image'] = dio_multi.MultipartFile.fromFile(
    //   user.image!,
    //   // filename: 'amalpr.jpg',
    // );
    ;
    data['location'] =
        '{"location":{"latitude":${markerPosition.latitude},"longitude":${markerPosition.longitude}}}';

    data['image'] = await dio_multi.MultipartFile.fromFile(
      imageFile!.path,
    );
    data['token'] = token;

    if (user.name != nameCtr.text.trim()) {
      data['name'] = nameCtr.text.trim();
    }
    if (user.name != emailCtr.text.trim()) {
      data['email'] = emailCtr.text.trim();
    }

    if (user.name != phoneCtr.text.trim()) {
      data['phone'] = phoneCtr.text.trim();
    }

    dio_form.FormData formData = dio_form.FormData.fromMap(data);

    try {
      isUpdating.value = true;

      log('===============>>>>>>>>>>>>>>>>>>>.' + formData.toString());
      log('token from profile =========> $token');
      final response = await dio.patch(baseUrl + updateProfile,
          data: formData,
          options: Options(
            headers: {"Authorization": "Bearer $token"},
          ));

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.back();

        customSnackbar(title: 'Update Success', msg: 'User details updated', barColor: snackGreen);
        log('Profile Update Success');
      }

      log(response.statusCode.toString());
      log(response.data.toString());
    } catch (e) {
      log('Error updateProfileInfo : $e');
    } finally {
      isUpdating.value = false;
    }
  }

  Future fetchfromDevice() async {
    bool status = await requestPermission();
    if (status) {
      getCurrentLocation();
    }
  }

  Future requestPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      return true;
    } else {
      return false;
    }
  }

  getCurrentLocation() async {
    isLoc.value = true;

    var p = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low, forceAndroidLocationManager: true);
    print('The current location isssssssssss');
    markerPosition = LatLng(p.latitude, p.longitude);

    log(p.latitude.toString());
    log(p.longitude.toString());
    isLoc.value = false;

    return p;
  }
}
