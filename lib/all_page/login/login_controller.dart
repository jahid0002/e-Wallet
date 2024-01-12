import 'package:class20/all_page/nav_bar/nav_ber.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  /// obscure pass text field

  bool _obscure = true;
  bool get obscure => _obscure;
  void obscureField() {
    _obscure = !_obscure;
    print(_obscure);
    update();
  }

  /// login method

  bool _loginLoading = false;
  bool get logingLoading => _loginLoading;

  final auth = FirebaseAuth.instance;

  void login({required String email, required String password}) async {
    _loginLoading = true;
    update();
    try {
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        _loginLoading = false;
        update();
        Get.snackbar('Succses!', 'Succesfully login');
        Get.offAll(() => NavBar());
      }).onError((error, stackTrace) {
        Get.snackbar('Error!', 'Cheek your email and password');
        _loginLoading = false;
        update();
      });
    } catch (e) {
      Get.snackbar('Error!', 'Cheek your email and password');
      _loginLoading = false;
      update();
    }
  }
}
