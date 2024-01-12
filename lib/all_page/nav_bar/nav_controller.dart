import 'package:class20/all_page/home/home_page.dart';
import 'package:class20/all_page/notification/send_money_succes_controller.dart';
import 'package:class20/all_page/settings/settings_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavController extends GetxController {
  RxInt currentIndex = RxInt(0);

  void changeIndex(int index) {
    currentIndex.value = index;
    update();
  }

  List<Widget> sceren = [
    HomePage(),
    Center(child: Text('contacts')),
    Center(child: Text('File')),
    SettingPage()
  ];

  @override
  void onInit() {
    super.onInit();
    token();
  }

  final auth = FirebaseAuth.instance;
  final store = FirebaseFirestore.instance.collection('user');
  void token() async {
    String? token = await SendMoneySucceseController().getToken();
    final email = auth.currentUser!.email;
    await store.doc(email).update({
      'token': token,
    }).then((value) {
      print(token);
    });
  }
}
