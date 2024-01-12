import 'package:class20/all_page/home/send_money_controller.dart';
import 'package:class20/const/all_color.dart';
import 'package:class20/global_widget/custom_appbar.dart';
import 'package:class20/global_widget/custom_button.dart';
import 'package:class20/global_widget/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SendMonyPage extends StatelessWidget {
  const SendMonyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SendMoneyController());
    final emailController = TextEditingController();
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: CustomAppbar.appbar(
          isLeading: true, isTitle: true, title: 'Send Money'),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Receiver Email',
                  style: TextStyle(
                      fontSize: 21,
                      color: AllColors.secendaryColors,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                CustomTextField(
                    controller: emailController,
                    hintText: 'Enter receiver email address',
                    validator: (value) {
                      return null;
                    })
              ],
            ),
            GetBuilder<SendMoneyController>(builder: (conext) {
              return CustomButtons(
                  loading: controller.sendMoneyLoading,
                  titile: 'Send',
                  onTap: () {
                    if (emailController.text.isNotEmpty) {
                      controller.sendMoney(emailController.text.toString());
                    }
                  });
            })
          ],
        ),
      ),
    );
  }
}
