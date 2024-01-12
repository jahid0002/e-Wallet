import 'package:class20/const/all_color.dart';
import 'package:class20/global_widget/custom_appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ActivityPage extends StatelessWidget {
  const ActivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final size = MediaQuery.sizeOf(context);
    final email = FirebaseAuth.instance.currentUser!.email;
    return Scaffold(
        appBar: CustomAppbar.appbar(
            isLeading: true,
            isTitle: true,
            title: 'Activity',
            actions: [
              const Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Icon(Icons.search_outlined),
              )
            ]),
        body: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('activity').snapshots(),
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
                          if (data[index]['senderEmail'].toString() == email) {
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
                                style: TextStyle(
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
                          } else if (data[index]['receiverEmail'].toString() ==
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
            }));
  }
}
