import 'package:flutter_application_1/models/ChatUser.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  FirestoreService._privateConstructor();
  static final FirestoreService instance =
      FirestoreService._privateConstructor();

  final FirebaseFirestore database = FirebaseFirestore.instance;

  final String userTable = "users";
  final String userTableNameField = "displayName";
  final String userTableMailField = "email";
  final String userTablePhotoUrlField = "photoUrl";

  Future<void> addUser(User _user, [String fbToken = ""]) async {
    await database.collection(userTable).doc(_user.uid.toString()).set({
      '$userTableMailField': _user.email,
      '$userTableNameField': _user.displayName,
      '$userTablePhotoUrlField': _user.photoURL! + fbToken,
    }, SetOptions(merge: true));
  }

  Future<bool> isUserExisted(User _user) async {
    DocumentSnapshot docs =
        await database.collection(userTable).doc(_user.uid.toString()).get();
    return docs.exists;
  }


  Future<ChatUser> getUserByEmail(String email) async {
    late ChatUser user;
    await database.collection(userTable).where('email',isEqualTo: email).get().then((value) {
      user = ChatUser.fromJson(value.docs[0].data());
    });
    return user;
  }

  Future<List<ChatUser>> getAllUsers() async {
    List<ChatUser> weathers = [];
    await database.collection(userTable).get().then((value) {
      value.docs.forEach((element) =>
          weathers.add(ChatUser.fromJson(element.data())));
    });
    return weathers;
  }
}
