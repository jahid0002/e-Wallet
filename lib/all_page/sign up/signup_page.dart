import 'package:class20/all_page/sign%20up/signup_controller.dart';
import 'package:class20/const/all_color.dart';
import 'package:class20/global_widget/custom_appbar.dart';

import 'package:class20/global_widget/custom_button.dart';
import 'package:class20/global_widget/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final controller = Get.put(SignupContrller());

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: CustomAppbar.appbar(
        isLeading: true,
      ),
      body: Center(
        child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset('asstes/images/Group12.png'),
                Form(
                    child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            CustomTextField(
                              controller: emailController,
                              hintText: 'Enter your email',
                              validator: (value) {
                                final cheek =
                                    controller.validateEmail(value.toString());
                                if (!cheek) {
                                  return 'Cheek Email';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            GetBuilder<SignupContrller>(builder: (conte) {
                              return CustomTextField(
                                  icon1: IconButton(
                                    icon: controller.obscure
                                        ? const Icon(
                                            Icons.remove_red_eye_outlined,
                                            size: 16,
                                          )
                                        : const Icon(
                                            Icons.remove_red_eye,
                                            size: 16,
                                          ),
                                    onPressed: () {
                                      controller.obscureField();
                                    },
                                  ),
                                  obscureText: controller.obscure,
                                  controller: passController,
                                  hintText: 'Enter your passworad',
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'enter the password';
                                    } else if (value.toString().length < 7) {
                                      // print(value.toString().length);

                                      return 'Enter the long password';
                                    } else {
                                      return null;
                                    }
                                  });
                            }),
                            SizedBox(
                              height: height * 0.03,
                            ),
                            GetBuilder<SignupContrller>(builder: (conxt) {
                              return CustomButtons(
                                  loading: controller.emailPassLoading,
                                  titile: 'Sign Up',
                                  onTap: () {
                                    if (formKey.currentState!.validate()) {
                                      controller.registerAuth(
                                          emailController.text.toString(),
                                          passController.text.toString());
                                    }
                                  });
                            })
                          ],
                        ))),
                Column(
                  children: [
                    const Text(
                      'All ready have an account??',
                      style: TextStyle(
                          fontSize: 19,
                          color: AllColors.textBlackColor,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 19,
                          color: AllColors.textBlackColor,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            )),
      ),
    );
  }
}
