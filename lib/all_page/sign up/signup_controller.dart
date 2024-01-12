import 'dart:io';

import 'package:class20/all_page/nav_bar/nav_ber.dart';
import 'package:class20/all_page/notification/send_money_succes_controller.dart';
import 'package:class20/all_page/sign%20up/get_information.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class SignupContrller extends GetxController {
  /// obscure pass text field

  bool _obscure = true;
  bool get obscure => _obscure;
  void obscureField() {
    _obscure = !_obscure;
    print(_obscure);
    update();
  }

  /// email validator
  bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern.toString());
    return (!regex.hasMatch(value)) ? false : true;
  }

  // firebase auth
  bool _emailPassLoading = false;
  bool get emailPassLoading => _emailPassLoading;

  final auth = FirebaseAuth.instance;
  void registerAuth(String email, String password) async {
    _emailPassLoading = true;
    update();
    try {
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        Get.snackbar(
          "Done",
          "succesfully signup your account",
          colorText: Colors.white,
          backgroundColor: Colors.lightBlue,
          icon: const Icon(Icons.add_alert),
        );
        Get.offAll(() => GetInformation(
              email: email,
              pass: password,
            ));
        _emailPassLoading = false;
        update();
      }).onError((error, stackTrace) {
        Get.snackbar(
          "Error",
          "Cheek your email and password",
          colorText: Colors.white,
          backgroundColor: Colors.red,
          icon: const Icon(Icons.add_alert),
        );
        _emailPassLoading = false;
        update();
      });
    } catch (e) {
      Get.snackbar(
        "Error",
        "Cheek your email and password",
        colorText: Colors.white,
        backgroundColor: Colors.lightBlue,
        icon: const Icon(Icons.add_alert),
      );
      _emailPassLoading = false;
      update();
    }
  }

  // user information store using firebase firestore ans cloud storage
  bool _informationLoading = false;
  bool get informationLoading => _informationLoading;
  final store = FirebaseFirestore.instance.collection('user');
  final storage = FirebaseStorage.instance
      .ref('image/' + '${DateTime.now().microsecondsSinceEpoch.toString()}');

  void getInformation({
    required String email,
    required String password,
    required String name,
    required String number,
    required String nid,
  }) async {
    String? token = await SendMoneySucceseController().getToken();
    update();
    if (_image == null) {
      try {
        await store.doc(email).set({
          'email': email,
          'password': password,
          'name': name,
          'number': number,
          'nid': nid,
          'image': null,
          'amount': 00.0.toString(),
          'token': token,
          'timeStump': Timestamp.now(),
        }).then((value) {
          _informationLoading = false;
          update();
          Get.snackbar('Succses', 'Information succesfully add');
          Get.offAll(() => NavBar());
        }).onError((error, stackTrace) {
          _informationLoading = false;
          update();
          Get.snackbar('Error', 'cheek your information');
        });
      } catch (e) {
        _informationLoading = false;
        update();
        Get.snackbar('Error', 'cheek your information');
      }
    } else {
      final uploadTask = storage.putFile(_image!.absolute);
      await Future.value(uploadTask).then((value) async {
        var newUrl = await storage.getDownloadURL();
        try {
          await store.doc(email).set({
            'email': email,
            'password': password,
            'name': name,
            'number': number,
            'nid': nid,
            'amount': 00.0.toString(),
            'image': newUrl.toString(),
            'timeStump': Timestamp.now(),
          }).then((value) {
            _informationLoading = false;
            update();
            Get.snackbar('Succses', 'Information succesfully add');
            Get.offAll(() => NavBar());
          }).onError((error, stackTrace) {
            _informationLoading = false;
            update();
            Get.snackbar('Error', 'cheek your information');
          });
        } catch (e) {
          _informationLoading = false;
          update();
          Get.snackbar('Error', 'cheek your information');
        }
      });
    }
  }

  // get profile image in user

  File? _image;
  File? get image => _image;

  void getImage(ImageSource source) async {
    final pickImage = await ImagePicker().pickImage(source: source);

    if (pickImage != null) {
      _image = File(pickImage.path);

      update();
    }
  }
}
