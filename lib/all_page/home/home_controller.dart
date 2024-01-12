import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getEmail();
  }

  String? _email;
  String? get email => _email;

  void getEmail() async {
    _email = await FirebaseAuth.instance.currentUser!.email;
    update();
  }
}
