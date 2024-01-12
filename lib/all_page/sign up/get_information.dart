import 'dart:io';

import 'package:class20/all_page/sign%20up/show_cammera_bottomseet.dart';
import 'package:class20/all_page/sign%20up/signup_controller.dart';
import 'package:class20/const/all_color.dart';
import 'package:class20/global_widget/custom_appbar.dart';
import 'package:class20/global_widget/custom_button.dart';
import 'package:class20/global_widget/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetInformation extends StatefulWidget {
  final String email;
  final String pass;
  const GetInformation({super.key, required this.email, required this.pass});

  @override
  State<GetInformation> createState() => _GetInformationState();
}

class _GetInformationState extends State<GetInformation> {
  final controller = Get.put(SignupContrller());
  final TextEditingController nameController = TextEditingController();
  final TextEditingController numController = TextEditingController();
  final TextEditingController nidController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: CustomAppbar.appbar(isTitle: true, title: 'Complete Setup'),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //  const SizedBox(height: 0.1,),
                GetBuilder<SignupContrller>(builder: (con) {
                  return Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      controller.image == null
                          ? const CircleAvatar(
                              radius: 75,
                              child: Icon(Icons.person, size: 100),
                            )
                          : CircleAvatar(
                              radius: 75,
                              backgroundImage:
                                  FileImage(File(controller.image!.path)),
                            ),
                      InkWell(
                        onTap: () {
                          ShowCameraBottomseet().bottomSheet(context);
                        },
                        child: Container(
                          height: height * 0.04,
                          width: height * 0.04,
                          decoration: BoxDecoration(
                            color: AllColors.secendaryColors,
                            shape: BoxShape.circle,
                            border: Border.all(color: AllColors.textWhiteColor),
                          ),
                          child: const Icon(
                            Icons.edit,
                            size: 18,
                            color: AllColors.textWhiteColor,
                          ),
                        ),
                      ),
                    ],
                  );
                }),

                Form(
                  key: formkey,
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: nameController,
                        hintText: 'Enter your name',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter the name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      CustomTextField(
                        keyboardType: TextInputType.phone,
                        controller: numController,
                        hintText: 'Enter your number',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter the number';
                          } else if (numController.toString().length < 10) {
                            return 'Enter the full number';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      CustomTextField(
                        keyboardType: TextInputType.phone,
                        controller: nidController,
                        hintText: 'Enter your nid',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter the nid';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),

                GetBuilder<SignupContrller>(builder: (coext) {
                  return CustomButtons(
                      loading: controller.informationLoading,
                      titile: 'Complete Setup',
                      onTap: () {
                        if (formkey.currentState!.validate()) {
                          controller.getInformation(
                              email: widget.email,
                              password: widget.pass,
                              name: nameController.text.toString(),
                              number: numController.text.toString(),
                              nid: nidController.text.toString());
                        }
                      });
                })
              ],
            ),
          ),
        ));
  }
}
