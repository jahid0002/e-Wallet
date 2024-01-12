import 'package:class20/all_page/nav_bar/nav_ber.dart';
import 'package:class20/all_page/notification/post_notification.dart';
import 'package:class20/const/all_color.dart';
import 'package:class20/global_widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SendMoneySucsses extends StatefulWidget {
  final String senderToken;
  final String receiverToken;
  final String senderEmail;
  final String receiverEmail;
  final String sendMoney;

  const SendMoneySucsses(
      {super.key,
      required this.receiverEmail,
      required this.sendMoney,
      required this.receiverToken,
      required this.senderEmail,
      required this.senderToken});

  @override
  State<SendMoneySucsses> createState() => _SendMoneySucssesState();
}

class _SendMoneySucssesState extends State<SendMoneySucsses> {
  final controller = PostNotificaion();

  @override
  void initState() {
    super.initState();
    controller.sendNotification(
        title: 'Send Money',
        token: widget.receiverToken,
        email: widget.senderEmail,
        sendMoney: widget.sendMoney);
    controller.sendNotification(
        title: 'Send Money Succesfully',
        token: widget.senderToken,
        email: widget.receiverEmail,
        sendMoney: widget.sendMoney);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.file_download_done_outlined,
                size: 70,
                color: AllColors.primaryColors,
              ),
              const Text(
                'Success!',
                style: TextStyle(
                    fontSize: 22,
                    color: AllColors.primaryColors,
                    fontWeight: FontWeight.w800),
              ),
              Text(
                '\$ ${widget.sendMoney}',
                style: const TextStyle(
                    fontSize: 25,
                    color: AllColors.textBlackColor,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                'has been send to ${widget.receiverEmail} from your wallet',
                style: const TextStyle(
                    fontSize: 15,
                    color: AllColors.textBlackColor,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              CustomButtons(
                  titile: 'check balance',
                  onTap: () {
                    Get.offAll(NavBar());
                  })
            ],
          ),
        ),
      ),
    );
  }
}
