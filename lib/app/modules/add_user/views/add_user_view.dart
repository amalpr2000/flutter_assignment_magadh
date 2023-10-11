import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_assignment_magadh/utils/constants.dart';

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
                      SizedBox(
                        height: 200,
                        child: GoogleMap(
                          onMapCreated: (controllermap) {
                            controller.mapController = controllermap;
                          },
                          initialCameraPosition: const CameraPosition(
                            target: LatLng(28.6139, 77.2090),
                            zoom: 15.0,
                          ),
                          markers: <Marker>{
                            Marker(
                              markerId: const MarkerId('myMarker'),
                              position: const LatLng(28.6139, 77.2090),
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
                      width: Get.width * 0.25,
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
