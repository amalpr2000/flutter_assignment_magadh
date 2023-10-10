import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserDetailsController extends GetxController {
  //TODO: Implement UserDetailsController

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
  late GoogleMapController mapController;
  late LatLng markerPosition;
}
