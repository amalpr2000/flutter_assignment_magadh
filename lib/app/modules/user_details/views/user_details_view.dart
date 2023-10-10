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
  int index = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('UserDetails'),
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: HomeController().fetchUsers(),
          builder: (context, snapshot) {
            double lat = snapshot.data!.users![index].location!.latitude ?? 0;
            double long = snapshot.data!.users![index].location!.longitude ?? 0;
            if (snapshot.data == null) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: Get.height * 0.05,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(img + snapshot.data!.users![index].image!),
                      radius: 80,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          margin: EdgeInsetsDirectional.symmetric(vertical: Get.height * 0.01),
                          width: Get.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15), color: kTileColor),
                          height: Get.height * 0.07,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Name'),
                              Text(snapshot.data!.users![index].name!),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          margin: EdgeInsetsDirectional.symmetric(vertical: Get.height * 0.01),
                          width: Get.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15), color: kTileColor),
                          height: Get.height * 0.07,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Email'),
                              Text(snapshot.data!.users![index].email!),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          margin: EdgeInsetsDirectional.symmetric(vertical: Get.height * 0.01),
                          width: Get.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15), color: kTileColor),
                          height: Get.height * 0.07,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Phone'),
                              Text(snapshot.data!.users![index].phone!),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          margin: EdgeInsetsDirectional.symmetric(vertical: Get.height * 0.02),
                          width: Get.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15), color: kTileColor),
                          height: Get.height * 0.07,
                          child: Center(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Location'),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                      'latititude : ${snapshot.data!.users![index].location!.latitude}'),
                                  Text(
                                      'longitude : ${snapshot.data!.users![index].location!.longitude}'),
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
            );
          },
        ));
  }
}
