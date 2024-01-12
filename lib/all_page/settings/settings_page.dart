import 'package:class20/all_page/login/login_page.dart';
import 'package:class20/global_widget/custom_appbar.dart';
import 'package:class20/global_widget/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar.appbar(
        isTitle: true,
        title: 'Settings',
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            CustomButtons(
                titile: 'Log Out',
                onTap: () async {
                  await FirebaseAuth.instance.signOut().then((value) {
                    Get.offAll(() => const LoginPage());
                  }).onError((error, stackTrace) {
                    Get.snackbar('Log out', 'Log out not succesfully');
                  });
                })
          ],
        ),
      ),
    );
  }
}
