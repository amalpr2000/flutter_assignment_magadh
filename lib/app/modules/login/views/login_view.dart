import 'package:flutter/material.dart';

import 'package:flutter_assignment_magadh/utils/colors.dart';
import 'package:flutter_assignment_magadh/utils/constants.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Obx(
            () => Visibility(
              visible: controller.isVisible.value,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    kHeight20,
                    const Text(
                      'Welcome',
                      style: TextStyle(fontSize: 25),
                      textAlign: TextAlign.center,
                    ),
                    kHeight20,
                    const Text(
                      'Sign in with Phone Number',
                      style: TextStyle(color: kSecondaryColor),
                      textAlign: TextAlign.center,
                    ),
                    kHeight40,
                    Container(
                      height: Get.height * 0.2,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  'https://ouch-cdn2.icons8.com/cd4gOHjDnZr4P7oWg3a39Up9S933BAdv6k5V5svDQMk/rs:fit:368:368/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9zdmcvODM1/L2U5MjdkYjczLTkx/MjQtNDA5Mi05Y2Iy/LTczMDJkOWU5Mjgx/NS5zdmc.png'))),
                    ),
                    kHeight40,
                    TextField(
                      controller: controller.phoneNumberController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.blueGrey[50],
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.white)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.white)),
                          prefixIcon: Icon(Icons.phone_android_rounded),
                          label: Text('Phone number'),
                          helperText: '',
                          hintText: 'Enter your phone number'),
                    ),
                    SizedBox(
                      height: Get.height * 0.065,
                      width: Get.width,
                      child: ElevatedButton(
                        onPressed: () {
                          controller.verifyNumber();
                        },
                        child: Text('Login'),
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 12.0),
                            shape:
                                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0))),
                      ),
                    )
                  ],
                ),
              ),
              replacement: SingleChildScrollView(
                child: Column(
                  children: [
                    kHeight20,
                    const Text(
                      'Welcome',
                      style: TextStyle(fontSize: 25),
                      textAlign: TextAlign.center,
                    ),
                    kHeight20,
                    const Text(
                      'Enter the OTP',
                      style: TextStyle(color: kSecondaryColor),
                      textAlign: TextAlign.center,
                    ),
                    kHeight40,
                    Container(
                      height: Get.height * 0.2,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  'https://ouch-cdn2.icons8.com/5CJF4MHxVUI8EcEUxl9SpenFPLYHYspo8XB8kbyTogo/rs:fit:368:368/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9zdmcvNjE2/L2VjZTMxY2Y4LWIx/MDctNGM0NC1iNzFm/LTQzOGZiNTlhZTRk/OC5zdmc.png'))),
                    ),
                    kHeight40,
                    Text(
                      'Otp for verification is ',
                      style: TextStyle(color: kSecondaryColor),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      ' ${controller.map['otp']}',
                      style: TextStyle(color: kPrimaryColor, fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Enter the OTP',
                          label: Text('Enter the OTP'),
                          filled: true,
                          fillColor: Colors.blueGrey[50],
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.white)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.white)),
                        ),
                        controller: controller.otpController,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    kHeight40,
                    SizedBox(
                      height: Get.height * 0.065,
                      width: Get.width,
                      child: ElevatedButton(
                        onPressed: () {
                          controller.verifyOtp();
                        },
                        child: Text('Verify'),
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 12.0),
                            shape:
                                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0))),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
