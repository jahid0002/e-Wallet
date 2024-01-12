import 'package:class20/all_page/home/send_mony_sucsses.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ReceiverDetailsController extends GetxController {
  bool _loading = false;
  bool get loading => _loading;
  final store = FirebaseFirestore.instance.collection('user');
  final store2 = FirebaseFirestore.instance.collection('activity');
  final auth = FirebaseAuth.instance;
// updsate firestore
  void updateFirebase() async {}

  /// send money method
  void getAmount({
    required double sendMoney,
    required Map<String, dynamic>? personalData,
    required Map<String, dynamic>? data,
  }) async {
    double receiverCurrentBalance = double.parse(data!['amount']);
    double currentBalance = double.parse(personalData!['amount']);
    double sendBalance = sendMoney;
    String currentEmail = personalData['email'].toString();
    String receiverEmail = data['email'].toString();
    String senderName = personalData['name'].toString();
    String receiverName = data['name'].toString();
    _loading = true;
    update();
    if (currentBalance < sendBalance || currentBalance == 0) {
      Get.snackbar('Insafient Balance', 'Plasse cheek your balance');
      _loading = false;
      update();
    } else {
      double sub = currentBalance - sendBalance;
      await store
          .doc(currentEmail)
          .update({'amount': sub.toString()}).then((value) async {
        double sum = receiverCurrentBalance + sendBalance;
        await store
            .doc(receiverEmail)
            .update({'amount': sum.toString()}).then((value) async {
          await store2
              .doc(DateTime.now().microsecondsSinceEpoch.toString())
              .set({
            'senderEmail': currentEmail,
            'receiverEmail': receiverEmail,
            'sendMoney': sendBalance.toString(),
            'senderName': senderName,
            'receiverName': receiverName,
            'timestump': Timestamp.now()
          }).then((value) {
            _loading = false;
            update();
            Get.to(() => SendMoneySucsses(
                  senderToken: personalData['token'].toString(),
                  receiverToken: data['token'].toString(),
                  senderEmail: currentEmail,
                  receiverEmail: receiverEmail,
                  sendMoney: sendBalance.toString(),
                ));
          }).onError((error, stackTrace) {
            Get.snackbar('Feild', "Send money feild");
            _loading = false;
            update();
          });
        }).onError((error, stackTrace) {
          Get.snackbar('Feild', "Send money feild");
          _loading = false;
          update();
        });
      }).onError((error, stackTrace) {
        Get.snackbar('Feild', "Send money feild");
        _loading = false;
        update();
      });
    }
  }
}
