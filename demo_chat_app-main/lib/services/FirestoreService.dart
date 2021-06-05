import 'package:demo_chat_app/models/ChatGroup.dart';
import 'package:demo_chat_app/models/ChatUser.dart';
import 'package:demo_chat_app/services/MessageService.dart';
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

  final String groupTable = "groups";
  final String people = "people";
  final String uid = "uid";

  Future<void> addUser(User _user, [String fbToken = ""]) async {
    await database.collection(userTable).doc(_user.uid.toString()).set({
      '$userTableMailField': _user.email,
      '$userTableNameField': _user.displayName,
      '$userTablePhotoUrlField': _user.photoURL + fbToken,
    }, SetOptions(merge: true));
  }

  Future<bool> isUserExisted(User _user) async {
    DocumentSnapshot docs =
        await database.collection(userTable).doc(_user.uid.toString()).get();
    return docs.exists;
  }

  static ChatUser getChatUserFromRaw(String uid, Map<String, dynamic> result) {
    return ChatUser(
      uid,
      result['email'],
      result['displayName'],
      result['photoUrl'],
    );
  }

  Future<ChatUser> getUser(String userUID) async {
    ChatUser user;
    await database.collection(userTable).doc(userUID).get().then((value) {
      user = getChatUserFromRaw(value.id, value.data());
    });
    return user;
  }

  Future<List<ChatUser>> getAllUsers() async {
    List<ChatUser> weathers = [];
    await database.collection(userTable).get().then((value) {
      value.docs.forEach((element) =>
          weathers.add(getChatUserFromRaw(element.id, element.data())));
    });
    return weathers;
  }

  static ChatGroup getChatGroupFromRaw(String id, Map<String, dynamic> result) {
    return ChatGroup(
      id,
      result['name'],
      List.from(result['people']),
    );
  }

  Future<ChatGroup> createChatGroup(List<String> people) async {
    ChatGroup chatGroup;
    await database.collection('groups').add({
      'name': "",
      'people': people,
    }).then((value) {
      chatGroup = ChatGroup(value.id, "", people);
    });
    return chatGroup;
  }

  Future<List<ChatGroup>> getChatGroups(String userUID) async {
    List<ChatGroup> chatGroups = [];
    await database
        .collection(groupTable)
        .where(people, arrayContains: userUID)
        .get()
        .then((value) => value.docs.forEach((element) {
              chatGroups.add(getChatGroupFromRaw(element.id, element.data()));
            }));
    for (var element in chatGroups) {
      ChatUser user;
      String user1 = element.peopleID[0], user2 = element.peopleID[1];
      if (user1 == user2) {
        user = await FirestoreService.instance.getUser(user1);
        element.name = "You";
      } else {
        if (user1 != userUID) {
          user = await FirestoreService.instance.getUser(user1);
        } else {
          user = await FirestoreService.instance.getUser(user2);
        }
      }
      element.photoUrl = user.photoUrl;
      if (element.name == "") element.name = user.displayName;
      element.lastMessage =
          await MessageService.instance.getLastMessage(element.id);
    }
    return chatGroups;
  }
}
