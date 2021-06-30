import 'package:flutter_application_1/models/User.dart';
import 'package:flutter_application_1/services/AuthenticService.dart';
import 'package:flutter_application_1/services/FirestoreService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/views/main/main_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class AuthenticController extends GetxController {
  var isSigningIn = false.obs;
  var isGuest = true.obs;
  // ignore: avoid_init_to_null
  MyUser? currentUser = null;
  Future<FirebaseApp> initilizeFirebase() async {
    return await AuthenticService.instance.initializeFirebase();
  }

  Future<bool> signInWithGoogle() async {
    isSigningIn.value = true;
    User? user = await AuthenticService.instance.signInWithGoogle();
    if (user != null) {
      bool isExisted = await FirestoreService.instance.isUserExisted(user);
      if (isExisted) {
        Fluttertoast.showToast(
            msg: "Chào mừng ${user.displayName} quay trở lại!",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER);
      } else {
        await FirestoreService.instance.addUser(user);
        Get.snackbar("Đăng nhập thành công", "Xin chao ${user.displayName}.");
      }
      currentUser =
          new MyUser(user.uid, user.email!, user.displayName!, user.photoURL!);
      currentUser!.typeAccount = 1;
      isSigningIn.value = false;
      isGuest.value = false;

      Get.offAll(() => MainScreen());

      return true;
    }
    Get.snackbar(
        "Đăng nhập thất bại", "Đã có lỗi xảy ra trong quá trình đăng nhập.");
    isSigningIn.value = false;
    return false;
  }

  Future signOutGoogle() async {
    await AuthenticService.instance.signOutGoogle();
    currentUser = null;
    isGuest.value = true;
    Get.offAll(() => MainScreen());
  }

  Future<bool> signInWithFacebook() async {
    isSigningIn.value = true;
    User? user = await AuthenticService.instance.signInWithFacebook();
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
            "Chào mừng ${user.displayName} đến với CheemsNews.");
      }
      currentUser =
          new MyUser(user.uid, user.email!, user.displayName!, user.photoURL!);
      currentUser!.typeAccount = 2;
      isGuest.value = false;
      isSigningIn.value = false;
      Get.offAll(() => MainScreen());

      return true;
    } else
      Get.snackbar(
          "Đăng nhập thất bại",
          "Đã có lỗi xảy ra trong quá trình đăng nhập." +
              AuthenticService.instance.handleError);
    isSigningIn.value = false;
    return false;
  }

  Future signOutFacebook() async {
    await AuthenticService.instance.signOutFacebook();
    currentUser = null;
    isGuest.value = true;
    Get.offAll(() => MainScreen());
  }
}
