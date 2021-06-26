import 'package:flutter_application_1/models/Comment.dart';
import 'package:flutter_application_1/models/News.dart';
import 'package:flutter_application_1/models/Title.dart';
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
      'favNews': [],
    }, SetOptions(merge: true));
  }

  Future<bool> isUserExisted(User _user) async {
    DocumentSnapshot docs =
        await database.collection(userTable).doc(_user.uid.toString()).get();
    return docs.exists;
  }

  Future<MyUser> getUserByEmail(String email) async {
    late MyUser user;
    await database
        .collection(userTable)
        .where('email', isEqualTo: email)
        .get()
        .then((value) {
      user = MyUser.fromJson(value.docs[0].data());
    });
    return user;
  }

  Future<List<MyUser>> getAllUsers() async {
    List<MyUser> weathers = [];
    await database.collection(userTable).get().then((value) {
      value.docs
          .forEach((element) => weathers.add(MyUser.fromJson(element.data())));
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

  Future<List<News>> getLimitNewsWithTag(String tag, int limit) async {
    List<News> thumb = [];
    await database
        .collection('news')
        .where('tag', arrayContainsAny: [tag])
        .limit(limit)
        .get()
        .then((value) => {
              value.docs.forEach((element) {
                thumb.add(News.fromJson(element.data()));
              })
            });
    return thumb;
  }

  Future<List<News>> getAllNewsWithTag(String tag) async {
    List<News> thumb = [];
    await database
        .collection('news')
        .where('tag', arrayContainsAny: [tag])
        .get()
        .then((value) => {
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

  Future<List<TypeNews>> getAllTag() async {
    List<TypeNews> thumb = [];
    await database.collection('typeNews').get().then((value) => {
          print(value.docs[0].data()),
          value.docs.forEach((element) {
            thumb.add(TypeNews.fromJson(element.data()));
          })
        });
    return thumb;
  }

  Future<List<String>> getListFav(String uID) async {
    List<String> listID = [];
    await database.collection('users').doc(uID).get().then((value) => {
          print(value.data()),
          if (value.data()!['favNews'] != null)
            listID = List.castFrom(value.data()!['favNews']),
        });
    return listID;
  }

  Future updateListFav(MyUser? _user, List<String> newsID) async {
    await database
        .collection('users')
        .doc(_user!.uid)
        .update(<String, dynamic>{'favNews': newsID}).catchError(
            (error) => print('Update Faile : $error'));
  }

  Future<void> addCmt(String newsID, Comments cmt) async {
    await database.collection("news").doc(newsID).collection("cmt").add(
      {
        'username': cmt.userName,
        'userimage': cmt.userImage,
        'body': cmt.body,
        'time': cmt.time.toString()
      },
    );
  }

  Future<List<Comments>> getAllCmt(String newsID) async {
    List<Comments> thumb = [];
    await database
        .collection('news')
        .doc(newsID)
        .collection("cmt")
        .get()
        .then((value) =>  {
              
              value.docs.forEach((element) {
                if (element.exists)
                  thumb.add(Comments.fromJson(element.data()));
              })
            });
    return thumb;
  }
}
