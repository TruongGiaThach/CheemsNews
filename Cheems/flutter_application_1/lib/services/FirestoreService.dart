import 'package:flutter_application_1/models/News.dart';
import 'package:flutter_application_1/models/User.dart';
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


  Future<myUser> getUserByEmail(String email) async {
    late myUser user;
    await database.collection(userTable).where('email',isEqualTo: email).get().then((value) {
      user = myUser.fromJson(value.docs[0].data());
    });
    return user;
  }

  Future<List<myUser>> getAllUsers() async {
    List<myUser> weathers = [];
    await database.collection(userTable).get().then((value) {
      value.docs.forEach((element) =>
          weathers.add(myUser.fromJson(element.data())));
    });
    return weathers;
  }

  Future<List<Thumbnail>> getAllNews() async{
    List<Thumbnail> thumb = [];
    await database.collection('news').get().then((value) => {
      print(value.docs[0].data()),
      value.docs.forEach((element) {
        thumb.add(Thumbnail.fromJson(element.data()));
       })
    });
    return thumb;
  }

}
