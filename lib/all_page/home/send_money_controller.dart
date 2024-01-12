import 'package:class20/all_page/home/receiver_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SendMoneyController extends GetxController {
  bool _sendMoneyLoading = false;
  bool get sendMoneyLoading => _sendMoneyLoading;
  final personalEmail = FirebaseAuth.instance.currentUser!.email;

  final store = FirebaseFirestore.instance.collection('user');

  void sendMoney(String email) async {
    _sendMoneyLoading = true;
    update();
    final parsonalData = await FirebaseFirestore.instance
        .collection('user')
        .doc(personalEmail.toString())
        .get();
    final data = await store.doc(email).get();
    // ignore: unnecessary_null_comparison
    if (data.data() == null) {
      print(data.data().toString());
      Get.snackbar('Not found', 'plasse cheek email');
      _sendMoneyLoading = false;
      update();
    } else {
      if (personalEmail.toString() == email) {
        Get.snackbar('Error', 'This is account email!');
        _sendMoneyLoading = false;
        update();
      } else {
        _sendMoneyLoading = false;
        update();
        Get.to(() => ReciverDetails(
              data: data.data(),
              personalData: parsonalData.data(),
            ));
      }
    }
  }
}
