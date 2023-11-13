import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_assignment_magadh/app/modules/home/controllers/home_controller.dart';

import 'package:flutter_assignment_magadh/utils/colors.dart';
import 'package:flutter_assignment_magadh/utils/constants.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../controllers/user_details_controller.dart';

class UserDetailsView extends GetView<UserDetailsController> {
  UserDetailsView({Key? key}) : super(key: key);
  // int index = Get.arguments;
  double get lat {
    return controller.user.location!.latitude ?? 0;
  }

  double get long {
    return controller.user.location!.longitude ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('UserDetails'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: Get.height * 0.05,
              ),
              CircleAvatar(
                backgroundImage: NetworkImage(controller.user.image != null
                    ? (img + controller.user.image!)
                    : 'https://edug.in/panel/head_admin/School/school_head/first_photo/DEMO59167.jpg'),
                radius: 80,
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      margin: EdgeInsetsDirectional.symmetric(vertical: Get.height * 0.01),
                      width: Get.width,
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(15), color: kTileColor),
                      height: Get.height * 0.07,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Name'),
                          Text(controller.user.name!),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      margin: EdgeInsetsDirectional.symmetric(vertical: Get.height * 0.01),
                      width: Get.width,
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(15), color: kTileColor),
                      height: Get.height * 0.07,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Email'),
                          Text(controller.user.email!),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      margin: EdgeInsetsDirectional.symmetric(vertical: Get.height * 0.01),
                      width: Get.width,
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(15), color: kTileColor),
                      height: Get.height * 0.07,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Phone'),
                          Text(controller.user.phone!),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      margin: EdgeInsetsDirectional.symmetric(vertical: Get.height * 0.02),
                      width: Get.width,
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(15), color: kTileColor),
                      height: Get.height * 0.07,
                      child: Center(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Location'),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('latititude : ${controller.user.location!.latitude}'),
                              Text('longitude : ${controller.user.location!.longitude}'),
                            ],
                          ),
                        ],
                      )),
                    ),
                    SizedBox(
                      height: 200,
                      child: GoogleMap(
                        onMapCreated: (controllermap) {
                          controller.mapController = controllermap;
                        },
                        initialCameraPosition: CameraPosition(
                          target: LatLng(lat, long),
                          zoom: 15.0,
                        ),
                        markers: <Marker>{
                          Marker(
                            markerId: const MarkerId('myMarker'),
                            position: LatLng(lat, long),
                            draggable: true,
                            onDragEnd: (newPosition) {
                              controller.markerPosition = newPosition;
                              log(controller.markerPosition.toString());
                            },
                          ),
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
