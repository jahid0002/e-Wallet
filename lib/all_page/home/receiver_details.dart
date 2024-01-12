import 'package:class20/all_page/home/receiver_detail_controller.dart';
import 'package:class20/const/all_color.dart';
import 'package:class20/global_widget/custom_appbar.dart';
import 'package:class20/global_widget/custom_button.dart';
import 'package:class20/global_widget/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReciverDetails extends StatelessWidget {
  final Map<String, dynamic>? data;
  final Map<String, dynamic>? personalData;
  const ReciverDetails(
      {super.key, required this.data, required this.personalData});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ReceiverDetailsController());
    final size = MediaQuery.sizeOf(context);
    final amountController = TextEditingController();
    return Scaffold(
      appBar: CustomAppbar.appbar(
          isLeading: true, isTitle: true, title: 'Send Money'),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Row(
                  children: [
                    data!['image'] == null
                        ? const CircleAvatar(
                            radius: 30,
                            child: Icon(Icons.person, size: 40),
                          )
                        : CircleAvatar(
                            radius: 30,
                            backgroundImage:
                                NetworkImage(data!['image'].toString()),
                          ),
                    SizedBox(
                      width: size.height * 0.03,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'To',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: AllColors.textBlackColor.withOpacity(0.6)),
                        ),
                        Text(
                          data!['name'].toString(),
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: AllColors.textBlackColor.withOpacity(0.9)),
                        ),
                        Text(
                          data!['email'].toString(),
                          style: TextStyle(
                              //fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: AllColors.textBlackColor.withOpacity(0.6)),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                CustomTextField(
                  controller: amountController,
                  hintText: 'Enter Amount',
                  validator: (value) {
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  icon: const Icon(Icons.attach_money_outlined),
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
                Text(
                    'Current Balance : \$${personalData!['amount'].toString()}'),
              ],
            ),
            GetBuilder<ReceiverDetailsController>(builder: (contxt) {
              return CustomButtons(
                  loading: controller.loading,
                  titile: 'Send',
                  onTap: () {
                    if (amountController.text.isNotEmpty) {
                      controller.getAmount(
                        sendMoney: double.parse(amountController.text),
                        data: data,
                        personalData: personalData,
                      );
                    }
                  });
            })
          ],
        ),
      ),
    );
  }
}
