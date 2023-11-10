import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SearchUserController extends GetxController {
  //TODO: Implement SearchUserController

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

  TextEditingController searchController = TextEditingController();
  String text = '';
  List searchList = [];
  search(String value) {
    text = value;
    searchValue();
  }

  searchValue() async {
    if (text != '') {
      // searchList=await FirebaseFirestore.instance
      //             .collection('pocketBuy')
      //             .doc('admin')
      //             .collection('products')
      //             .get().then((value) => value.docs.where((element) {
      //               var name=element['productName'] as String;
      //               var brand=element['productBrand'] as String;
      //               if(name.toLowerCase().contains(text.toLowerCase().trim())){
      //                 return true;
      //               }
      //               return false;
      //             }).toList());
    } else {
      searchList = [];
    }
    update();
  }
}
