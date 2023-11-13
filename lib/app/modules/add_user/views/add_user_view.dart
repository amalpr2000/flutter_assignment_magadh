import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_assignment_magadh/utils/colors.dart';
import 'package:flutter_assignment_magadh/utils/constants.dart';
import 'package:flutter_assignment_magadh/utils/snackbar.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../controllers/add_user_controller.dart';

class AddUserView extends GetView<AddUserController> {
  const AddUserView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add User'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                controller.fetchfromDevice();
              },
              icon: Icon(Icons.my_location_sharp))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                ),
                Form(
                  key: controller.formkey1,
                  child: TextFormField(
                    controller: controller.namecontroller,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter the name';
                      }
                    },
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.blueGrey[50],
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.white)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.white)),
                        prefixIcon: Icon(Icons.person),
                        label: Text('Name'),
                        helperText: '',
                        hintText: 'Enter the name'),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Form(
                  key: controller.formkey2,

                  child: TextFormField(
                    controller: controller.phonecontroller,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter the phone Number';
                      }
                      if (!RegExp(r"^[0-9]{10}$").hasMatch(value)) {
                        customSnackbar(
                            title: 'Format incorrect',
                            msg: 'Enter a valid phone number',
                            barColor: snackred);
                        return 'Invalid phone number format';
                      }
                    },
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                    decoration: InputDecoration(
                        counterText: "",
                        filled: true,
                        fillColor: Colors.blueGrey[50],
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.white)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.white)),
                        prefixIcon: Icon(Icons.phone),
                        label: Text('Phone'),
                        helperText: '',
                        hintText: 'Enter your number'),
                  ),
                  // ),
                ),
                SizedBox(
                  height: 10,
                ),
                Form(
                  key: controller.formkey3,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: controller.emailcontroller,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter the email';
                          }
                          if (!RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
                            customSnackbar(
                                title: 'Format incorrect',
                                msg: 'Enter a valid E-mail',
                                barColor: snackred);
                            return 'Enter a valid E-mail';
                          }
                          ;
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.blueGrey[50],
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Colors.white)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Colors.white)),
                            prefixIcon: Icon(Icons.email_outlined),
                            label: Text('Email'),
                            helperText: '',
                            hintText: 'Enter your email'),
                      ),
                      kHeight10,
                      Text('Select the location'),
                      kHeight20,
                      Obx(
                        () => controller.isLoc.value
                            ? Stack(
                                children: [
                                  SizedBox(
                                    child: SizedBox(
                                      height: 200,
                                      child: GoogleMap(
                                        onMapCreated: (controllermap) {
                                          controller.mapController = controllermap;

                                          controller.markerPosition = controller.markerPosition;
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
                                child: SizedBox(
                                  height: 200,
                                  child: GoogleMap(
                                    onMapCreated: (controllermap) {
                                      controller.mapController = controllermap;

                                      controller.markerPosition = controller.markerPosition;
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
                    ],
                  ),
                ),
                kHeight40,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: Get.width * 0.25,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 12.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0))),
                          onPressed: (() {
                            if (controller.formkey1.currentState!.validate() &&
                                controller.formkey2.currentState!.validate() &&
                                controller.formkey3.currentState!.validate()) {
                              controller.createUser();
                            }
                          }),
                          child: Text(
                            'Add',
                          )),
                    ),
                    SizedBox(
                      width: 80,
                    ),
                    SizedBox(
                      width: Get.width * 0.26,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 12.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0))),
                          onPressed: (() {
                            Get.back();
                          }),
                          child: Text(
                            'Cancel',
                          )),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
