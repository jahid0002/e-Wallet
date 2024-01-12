import 'package:class20/all_page/home/activity_page.dart';
import 'package:class20/all_page/home/send_mony_page.dart';
import 'package:class20/const/all_color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final height = size.height;
    final email = FirebaseAuth.instance.currentUser!.email;
    return Scaffold(
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Column(
          children: [
            Container(
              height: size.height * 0.36,
              width: size.width,
              decoration: const BoxDecoration(
                  color: AllColors.secendaryColors,
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(40))),
              child: SafeArea(
                  child: Padding(
                padding: const EdgeInsets.only(left: 25, right: 25, top: 10),
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('user')
                        .doc(email)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final data = snapshot.data!.data();
                        print(data!['name'].toString());
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset('asstes/images/Group13.png'),
                                data['image'] == null
                                    ? Container(
                                        alignment: Alignment.center,
                                        height: size.height * 0.05,
                                        width: size.height * 0.05,
                                        decoration: BoxDecoration(
                                          color: AllColors.textWhiteColor,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: const Icon(
                                          Icons.person,
                                          size: 40,
                                        ))
                                    : Container(
                                        alignment: Alignment.center,
                                        height: size.height * 0.05,
                                        width: size.height * 0.05,
                                        decoration: BoxDecoration(
                                            color: AllColors.textWhiteColor,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    data['image'])))),
                              ],
                            ),
                            SizedBox(
                              height: size.height * .03,
                            ),
                            Text(
                              'Hello ${data['name']}!',
                              style: TextStyle(
                                  fontSize: 25,
                                  color: AllColors.textWhiteColor
                                      .withOpacity(0.6)),
                            ),
                            SizedBox(
                              height: size.height * .07,
                            ),
                            Text(
                              "\$${data['amount'].toString()}",
                              style: const TextStyle(
                                  fontSize: 45,
                                  color: AllColors.textWhiteColor,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              'Your Balance',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: AllColors.textWhiteColor
                                      .withOpacity(0.9)),
                            ),
                          ],
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(
                              color: AllColors.secendaryColors),
                        );
                      }
                    }),
              )),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0, top: 20),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Get.to(() => SendMonyPage());
                    },
                    child: Container(
                      height: size.height * 0.17,
                      width: size.height * 0.14,
                      decoration: BoxDecoration(
                          color: AllColors.secendaryColors,
                          borderRadius: BorderRadius.circular(30)),
                      child: const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.ios_share_outlined,
                              color: AllColors.textWhiteColor,
                              size: 35,
                            ),
                            Text(
                              ' Send\nMoney',
                              style: TextStyle(
                                  color: AllColors.textWhiteColor,
                                  fontSize: 20),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.height * 0.02,
                  ),
                  Container(
                    height: size.height * 0.17,
                    width: size.height * 0.14,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: AllColors.secendaryColors,
                          width: 1,
                        )),
                    child: const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.file_download_outlined,
                            color: AllColors.textBlackColor,
                            size: 35,
                          ),
                          Text(
                            ' Add\nMony',
                            style: TextStyle(
                                color: AllColors.textBlackColor, fontSize: 20),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0, top: 25, right: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Activity',
                    style: TextStyle(
                        fontSize: 23, color: AllColors.textBlackColor),
                  ),
                  InkWell(
                      onTap: () {
                        Get.to(() => const ActivityPage());
                      },
                      child: const Text(
                        'view all',
                        style: TextStyle(
                            fontSize: 20, color: AllColors.textBlackColor),
                      )),
                ],
              ),
            ),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('activity')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final data = snapshot.data!.docs;
                    return Expanded(
                        child: ListView.builder(
                            reverse: true,
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              DateTime time = data[index]['timestump'].toDate();
                              if (data[index]['senderEmail'].toString() ==
                                  email) {
                                return ListTile(
                                  leading: CircleAvatar(
                                    radius: 30,
                                    child: Text(
                                      data[index]['receiverName'][0],
                                      style: const TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.w900,
                                          color: AllColors.textBlackColor),
                                    ),
                                  ),
                                  title: Text(
                                    data[index]['receiverName'].toString(),
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: AllColors.textBlackColor),
                                  ),
                                  subtitle: Text(
                                    DateFormat.yMd()
                                        .add_jm()
                                        .format(time)
                                        .toString(),
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: AllColors.textBlackColor),
                                  ),
                                  trailing: Text(
                                    '-\$${data[index]['sendMoney']}',
                                    style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.red),
                                  ),
                                );
                              } else if (data[index]['receiverEmail']
                                      .toString() ==
                                  email) {
                                return ListTile(
                                  leading: CircleAvatar(
                                    radius: 30,
                                    child: Text(
                                      data[index]['senderName'][0],
                                      style: const TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.w900,
                                          color: AllColors.textBlackColor),
                                    ),
                                  ),
                                  title: Text(
                                    data[index]['senderName'].toString(),
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: AllColors.textBlackColor),
                                  ),
                                  subtitle: Text(
                                    DateFormat.yMd()
                                        .add_jm()
                                        .format(time)
                                        .toString(),
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: AllColors.textBlackColor),
                                  ),
                                  trailing: Text(
                                    '+\$${data[index]['sendMoney']}',
                                    style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w500,
                                        color: AllColors.primaryColors),
                                  ),
                                );
                              } else {
                                return const SizedBox();
                              }
                            }));
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(
                          color: AllColors.secendaryColors),
                    );
                  }
                })
          ],
        ),
      ),
    );
  }
}
