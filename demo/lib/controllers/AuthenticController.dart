import 'package:demo_chat_app/models/ChatUser.dart';
import 'package:demo_chat_app/services/AuthenticService.dart';
import 'package:demo_chat_app/services/FirestoreService.dart';
import 'package:demo_chat_app/views/home/HomeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class AuthenticController extends GetxController {
  var isSigningIn = false.obs;
  Future<FirebaseApp> initilizeFirebase() async {
    return await AuthenticService.instance.initializeFirebase();
  }

  Future<bool> signInWithGoogle() async {
    isSigningIn.value = true;
    User user = await AuthenticService.instance.signInWithGoogle();
    if (user != null) {
      bool isExisted = await FirestoreService.instance.isUserExisted(user);
      if (isExisted) {
        Fluttertoast.showToast(
            msg: "Chào mừng ${user.displayName} quay trở lại!",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER);
      } else {
        await FirestoreService.instance.addUser(user);
        Get.snackbar("Đăng nhập thành công",
            "Chào mừng ${user.displayName} đến với Chat App.");
      }
      Get.off(() => HomeScreen(
          ChatUser(user.uid, user.email, user.displayName, user.photoURL), 1));
      isSigningIn.value = false;
      return true;
    } else
      Get.snackbar(
          "Đăng nhập thất bại", "Đã có lỗi xảy ra trong quá trình đăng nhập.");
    isSigningIn.value = false;
    return false;
  }

  Future signOutGoogle() async {
    await AuthenticService.instance.signOutGoogle();
    Get.offAllNamed('/loginView');
  }

  Future<bool> signInWithFacebook() async {
    isSigningIn.value = true;
    User user = await AuthenticService.instance.signInWithFacebook();
    if (user != null) {
      String token = AuthenticService.instance.fbAcessToken;
      bool isExisted = await FirestoreService.instance.isUserExisted(user);
      if (isExisted) {
        Fluttertoast.showToast(
            msg: "Chào mừng ${user.displayName} quay trở lại!",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER);
      } else {
        await FirestoreService.instance.addUser(user, "?access_token=" + token);
        Get.snackbar("Đăng nhập thành công",
            "Chào mừng ${user.displayName} đến với Chat App.");
      }
      Get.off(() => HomeScreen(
          ChatUser(user.uid, user.email, user.displayName,
              user.photoURL + "?access_token=" + token),
          2));
      isSigningIn.value = false;
      return true;
    } else
      Get.snackbar(
          "Đăng nhập thất bại", "Đã có lỗi xảy ra trong quá trình đăng nhập.");
    isSigningIn.value = false;
    return false;
  }

  Future signOutFacebook() async {
    await AuthenticService.instance.signOutFacebook();
    Get.offAllNamed('/loginView');
  }
}
