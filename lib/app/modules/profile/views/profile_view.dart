import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_assignment_magadh/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_assignment_magadh/app/routes/app_pages.dart';
import 'package:flutter_assignment_magadh/utils/colors.dart';
import 'package:flutter_assignment_magadh/utils/constants.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  Get.defaultDialog(
                    title: 'Logout',
                    content: Text('Are you sure ?'),
                    onCancel: () {
                      Get.back();
                    },
                    onConfirm: () {
                      controller.signOut();
                    },
                  );
                },
                icon: Icon(Icons.logout_rounded)),
            IconButton(
                onPressed: () {
                  controller.fetchfromDevice();
                },
                icon: Icon(Icons.my_location_sharp))
          ],
        ),
        body: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Obx(() => !controller.isLoading.value
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: InkWell(
                        onTap: () {
                          controller.imgUpdate();
                        },
                        child: GetBuilder(
                            init: controller,
                            builder: (controller) {
                              return CircleAvatar(
                                backgroundImage: controller.imgPath == 'x'
                                    ? NetworkImage(
                                        // scale: 50,
                                        'https://edug.in/panel/head_admin/School/school_head/first_photo/DEMO59167.jpg')
                                    : controller.imgPath == 'xx'
                                        ? FileImage(File(controller.localPath)) as ImageProvider
                                        : NetworkImage(
                                            img + controller.imgPath,
                                          ),
                                radius: 70,
                              );
                            }),
                      ),
                    ),
                    kHeight10,
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Column(
                        children: [
                          TextField(
                            controller: controller.nameCtr,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.person),
                              filled: true,
                              fillColor: Color.fromARGB(255, 242, 243, 245),
                              contentPadding: const EdgeInsets.all(20),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(color: Colors.white, width: 0.0),
                              ),
                              labelText: 'Name',
                              labelStyle: const TextStyle(color: kSecondaryColor),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                          ),
                          kHeight20,
                          TextField(
                            controller: controller.emailCtr,
                            decoration: InputDecoration(
                              labelText: 'E-mail',
                              prefixIcon: const Icon(Icons.mail_rounded),
                              filled: true,
                              fillColor: Color.fromARGB(255, 242, 243, 245),
                              contentPadding: const EdgeInsets.all(20),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(color: Colors.white, width: 0.0),
                              ),
                              labelStyle: const TextStyle(color: kSecondaryColor),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                          ),
                          kHeight20,
                          TextField(
                            controller: controller.phoneCtr,
                            decoration: InputDecoration(
                              labelText: 'Phone',

                              prefixIcon: const Icon(Icons.phone_android_rounded),
                              filled: true,
                              fillColor: Color.fromARGB(255, 242, 243, 245),
                              contentPadding: const EdgeInsets.all(20),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(color: Colors.white, width: 0.0),
                              ),
                              // labelText: 'Name',
                              labelStyle: const TextStyle(color: kSecondaryColor),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                          ),
                          kHeight20,
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                            ),
                            child: Obx(
                              () => controller.isLoc.value
                                  ? Stack(
                                      children: [
                                        SizedBox(
                                          height: 200,
                                          child: GoogleMap(
                                            onMapCreated: (controllermap) {
                                              controller.mapController = controllermap;
                                            },
                                            initialCameraPosition: CameraPosition(
                                              target: controller.markerPosition,
                                              zoom: 15.0,
                                            ),
                                            markers: <Marker>{
                                              Marker(
                                                markerId: const MarkerId('myMarker'),
                                                position: controller.markerPosition,
                                                draggable: true,
                                                onDragEnd: (newPosition) {
                                                  controller.markerPosition = newPosition;
                                                  log(controller.markerPosition.toString());
                                                },
                                              ),
                                            },
                                          ),
                                        ),
                                        Container(
                                          height: 200,
                                          width: double.infinity,
                                          color: Colors.white.withOpacity(.5),
                                          child: Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                        )
                                      ],
                                    )
                                  : SizedBox(
                                      height: 200,
                                      child: GoogleMap(
                                        onMapCreated: (controllermap) {
                                          controller.mapController = controllermap;
                                        },
                                        initialCameraPosition: CameraPosition(
                                          target: controller.markerPosition,
                                          zoom: 15.0,
                                        ),
                                        markers: <Marker>{
                                          Marker(
                                            markerId: const MarkerId('myMarker'),
                                            position: controller.markerPosition,
                                            draggable: true,
                                            onDragEnd: (newPosition) {
                                              controller.markerPosition = newPosition;
                                              log(controller.markerPosition.toString());
                                            },
                                          ),
                                        },
                                      ),
                                    ),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          SizedBox(
                            width: 150,
                            child: Obx(
                              () => ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 25.0, vertical: 12.0),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12.0)),
                                      backgroundColor:
                                          controller.isUpdating.value ? Colors.grey : null),
                                  onPressed: (() {
                                    controller.isUpdating.value
                                        ? null
                                        : controller.updateProfileInfo();
                                  }),
                                  child: Text(
                                    controller.isUpdating.value ? 'Updating..' : 'Update',
                                  )),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              : SizedBox(
                  height: 600,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )),
        ));
  }
}
