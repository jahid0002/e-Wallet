import 'package:class20/all_page/sign%20up/signup_controller.dart';
import 'package:class20/const/all_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ShowCameraBottomseet {
  final controller = Get.put(SignupContrller());
  bottomSheet(context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                ListTile(
                  onTap: () {
                    controller.getImage(ImageSource.gallery);
                    Navigator.pop(context);
                  },
                  leading: Icon(
                    Icons.image,
                    color: AllColors.secendaryColors,
                    size: 25,
                  ),
                  title: Text(
                    'Gallary',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: AllColors.textBlackColor),
                  ),
                ),
                ListTile(
                  onTap: () {
                    controller.getImage(ImageSource.camera);
                    Navigator.pop(context);
                  },
                  leading: Icon(
                    Icons.camera,
                    color: AllColors.secendaryColors,
                    size: 25,
                  ),
                  title: Text(
                    'Camera',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: AllColors.textBlackColor),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
