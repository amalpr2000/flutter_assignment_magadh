import 'package:flutter/material.dart';
import 'package:flutter_assignment_magadh/utils/colors.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app/routes/app_pages.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    GetMaterialApp(
      title: "Application",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: kPrimaryColor,
        fontFamily: GoogleFonts.sniglet().fontFamily,
      ),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
