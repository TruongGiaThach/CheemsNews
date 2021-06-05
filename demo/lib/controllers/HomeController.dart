import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_chat_app/models/ChatGroup.dart';
import 'package:demo_chat_app/models/ChatUser.dart';
import 'package:demo_chat_app/services/FirestoreService.dart';
import 'package:demo_chat_app/services/MessageService.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var selectedIndex = 0.obs;
  var people = <ChatUser>[].obs;
  var chatGroups = <ChatGroup>[].obs;
  var isLoading = false.obs;
  ChatUser user;
  StreamSubscription<QuerySnapshot> _listenChatGroup, _listenLastMess;
  int signInType;

  Future getPeople() async {
    //isLoading.value = true;
    people.value = await FirestoreService.instance.getAllUsers();
    isLoading.value = false;
  }

  Future getChatGroup() async {
    //isLoading.value = true;
    chatGroups.value = await FirestoreService.instance.getChatGroups(user.uid);
    isLoading.value = false;
  }

  void startListenToChange() {
    if (_listenChatGroup == null || _listenChatGroup.isBlank) {
      print("listen chat gr");
      _listenChatGroup = FirestoreService.instance.database
          .collection("groups")
          .snapshots()
          .listen((event) {
        event.docChanges.forEach((element) async {
          await getChatGroup();
        });
      });
    }
    if (_listenLastMess == null || _listenLastMess.isBlank) {
      print("listen last mess");
      _listenLastMess = MessageService.instance.database
          .collection('messages')
          .snapshots()
          .listen((event) {
        event.docChanges.forEach((element) async {
          bool needUpdate = false;
          for (var chatGroup in chatGroups) {
            if (element.doc.data()['groupId'] == chatGroup.id) {
              needUpdate = true;
              chatGroup.lastMessage =
                  await MessageService.instance.getLastMessage(chatGroup.id);
              chatGroup.seen = false;
            }
            if (needUpdate) chatGroups.value = List.from(chatGroups.value);
          }
        });
      });
    }
  }

  @override
  void onClose() {
    _listenChatGroup.cancel();
    _listenLastMess.cancel();
    super.onClose();
  }
}
