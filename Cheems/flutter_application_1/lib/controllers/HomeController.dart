import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/models/ChatGroup.dart';
import 'package:flutter_application_1/models/ChatUser.dart';
import 'package:flutter_application_1/services/FirestoreService.dart';
import 'package:flutter_application_1/services/MessageService.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var selectedIndex = 0.obs;
  var people = <ChatUser>[].obs;
  var chatGroups = <ChatGroup>[].obs;
  var isLoading = false.obs;
  late ChatUser user;
  late StreamSubscription<QuerySnapshot> _listenChatGroup, _listenLastMess;
  late int signInType;

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


  @override
  void onClose() {
    _listenChatGroup.cancel();
    _listenLastMess.cancel();
    super.onClose();
  }
}