import 'package:class20/all_page/login/login_controller.dart';
import 'package:class20/all_page/sign%20up/signup_page.dart';
import 'package:class20/const/all_color.dart';
import 'package:class20/global_widget/custom_button.dart';
import 'package:class20/global_widget/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final controller = Get.put(LoginController());
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
      appBar: AppBar(),
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
                                if (value!.isEmpty) {
                                  return 'enter the email';
                                }
                                return null;
                              }),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          GetBuilder<LoginController>(builder: (cxt) {
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
                                  }
                                  return null;
                                });
                          }),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          GetBuilder<LoginController>(builder: (cont) {
                            return CustomButtons(
                                loading: controller.logingLoading,
                                titile: 'Login',
                                onTap: () {
                                  if (formKey.currentState!.validate()) {
                                    controller.login(
                                        email: emailController.text.toString(),
                                        password:
                                            passController.text.toString());
                                  }
                                });
                          })
                        ],
                      ))),
              Column(
                children: [
                  const Text(
                    'Having trouble logging in?',
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
                      Get.to(() => const SignupPage());
                    },
                    child: const Text(
                      'Sign up',
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
          ),
        ),
      ),
    );
  }
}
