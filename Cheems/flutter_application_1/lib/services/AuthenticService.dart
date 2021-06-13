import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';

class AuthenticService {
  AuthenticService._privateConstructor();
  static final AuthenticService instance =
      AuthenticService._privateConstructor();
  late FirebaseAuth _firebaseAuth;
  late GoogleSignIn _googleSignIn;
  late String fbAcessToken;
  late String ggAccessToken;
  late String handleError;
  Future<FirebaseApp> initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    _firebaseAuth = FirebaseAuth.instance;
    _googleSignIn = GoogleSignIn();
    await Future.delayed(Duration(seconds: 1));
    return firebaseApp;
  }

  Future<User?> signInWithGoogle() async {
    handleError = "";
    late User? user;
    final GoogleSignInAccount? googleSignInAccount =
        await _googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
    ggAccessToken = googleSignInAuthentication.accessToken!;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await _firebaseAuth.signInWithCredential(credential);

        user = userCredential.user;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          print("account exists");// handle the error here
        } else if (e.code == 'invalid-credential') {
          // handle the error here
        }
      } catch (e) {
        // handle the error here
      }
    } else
      user = null;
    return user;
  }

  Future signOutGoogle() async {
    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }

  Future<User?> signInWithFacebook() async {
    handleError = "";
    User? user;
    final FacebookLogin _facebookLogin = FacebookLogin();
    final res = await _facebookLogin.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);
    try {
      print(res.status.toString());
      switch (res.status) {
        case FacebookLoginStatus.success:
          final OAuthCredential facebookAuthCredential =
              FacebookAuthProvider.credential(res.accessToken!.token);
          fbAcessToken = res.accessToken!.token;
          print("token: " + fbAcessToken);

          final UserCredential userCredential =
              await _firebaseAuth.signInWithCredential(facebookAuthCredential);
          user = userCredential.user;
          print((user != null) ? user.uid : "null user");
          break;
        case FacebookLoginStatus.cancel:
          throw FirebaseAuthException(code: "fb-cancel-login");
        case FacebookLoginStatus.error:
          throw FirebaseAuthException(code: "fb-login-error");
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'account-exists-with-different-credential':
          handleError = "Email này đã được sử dụng";
          print("account-exists-with-different-credential");
          break;
        case 'invalid-credential':
          print("invalid-credential");
          break;
        case 'fb-cancel-login':
          print("fb-cancel-login");
          break;
        case 'fb-login-error':
          print("fb-login-error");
          break;
      }
    } catch (e) {
      print(e.toString());
    }

    return user;
  }

  Future signOutFacebook() async {
    await FacebookAuth.instance.logOut();
    await _firebaseAuth.signOut();
  }
}
