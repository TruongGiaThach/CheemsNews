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
    await database
        .collection(userTable)
        .where('email', isEqualTo: email)
        .get()
        .then((value) {
      user = myUser.fromJson(value.docs[0].data());
    });
    return user;
  }

  Future<List<myUser>> getAllUsers() async {
    List<myUser> weathers = [];
    await database.collection(userTable).get().then((value) {
      value.docs
          .forEach((element) => weathers.add(myUser.fromJson(element.data())));
    });
    return weathers;
  }

  Future<List<News>> getAllNews() async {
    List<News> thumb = [];
    await database.collection('news').get().then((value) => {
          print(value.docs[0].data()),
          value.docs.forEach((element) {
            thumb.add(News.fromJson(element.data()));
          })
        });
    return thumb;
  }

  Future<List<News>> getLimitNewsWithTag(String tag) async {
    List<News> thumb = [];
    await database
        .collection('news')
        //.where('tag', arrayContains: ['Du lịch'])
        .get()
        .then((value) => {
              print(value.docs[0].data()),
              value.docs.forEach((element) {
                thumb.add(News.fromJson(element.data()));
              })
            });
    return thumb;
  }

  Future<News?> getNewsById(String id) async {
    late News? tmp;

    await database
        .collection('news')
        .doc(id)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        tmp = News.fromJson(documentSnapshot.data()!);
        print(tmp!.author);
      } else {
        print('Document does not exist on the database');
        tmp = null;
      }
    });
    return tmp;
  }
}
