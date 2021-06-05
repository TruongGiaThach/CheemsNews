import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_chat_app/models/ChatGroup.dart';
import 'package:demo_chat_app/models/ChatUser.dart';
import 'package:demo_chat_app/models/Message.dart';
import 'package:demo_chat_app/services/FirestoreService.dart';
import 'package:demo_chat_app/services/MessageService.dart';
import 'package:demo_chat_app/services/StorageService.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class ChatController extends GetxController {
  TextEditingController mainTextController = TextEditingController();
  ScrollController scrollController = new ScrollController();
  var messages = <Message>[].obs;
  var isLoading = false.obs;
  var chatNewUser = false.obs;
  ChatGroup chatGroup;
  ChatUser mainUser;
  ChatUser partner;

  StreamSubscription<QuerySnapshot> _eventsSubscription;
  StreamSubscription<QuerySnapshot> _listenChatGroup;
  void startListenToChange() {
    if (!chatNewUser.value) {
      print("start listen msg");
      _eventsSubscription = MessageService.instance.database
          .collection('messages')
          .snapshots()
          .listen((event) {
        event.docChanges.forEach((element) {
          if (element.doc.data()['groupId'] == chatGroup.id &&
              element.doc.data()['senderUid'] == mainUser.uid) {
            getMessage();
          }
        });
      });
    }
  }

  void startListenStartConversation() {
    if (chatNewUser.value) {
      print("start listen conversation");
      _listenChatGroup = FirestoreService.instance.database
          .collection("groups")
          .snapshots()
          .listen((event) {
        ChatGroup tempChatGroup;
        event.docChanges.forEach((element) async {
          tempChatGroup = FirestoreService.getChatGroupFromRaw(
              element.doc.id, element.doc.data());
          if (tempChatGroup.peopleID.length == 2 &&
                  (mainUser.uid == partner.uid &&
                      tempChatGroup.peopleID[0] == tempChatGroup.peopleID[1] &&
                      tempChatGroup.peopleID[1] == mainUser.uid) ||
              ((mainUser.uid != partner.uid &&
                  tempChatGroup.peopleID.contains(mainUser.uid) &&
                  tempChatGroup.peopleID.contains(partner.uid)))) {
            print("start conversation");
            chatGroup = tempChatGroup;
            chatGroup.photoUrl = partner.photoUrl;
            chatGroup.name = partner.displayName;
            chatNewUser.value = false;
            _listenChatGroup.cancel();
            if (_eventsSubscription == null || _eventsSubscription.isBlank)
              startListenToChange();
          }
        });
      });
    }
  }

  sendMessage(int type) async {
    if (mainTextController.isBlank) return;
    Message message = Message(
        mainUser.uid,
        (chatNewUser.value) ? "" : chatGroup.id,
        mainTextController.text,
        DateTime.now().millisecondsSinceEpoch,
        type);
    mainTextController.clear();
    if (message.groupID == null || message.groupID == "") {
      chatGroup = await FirestoreService.instance
          .createChatGroup([mainUser.uid, partner.uid]);
      print("create group");
      if (_listenChatGroup != null && !_listenChatGroup.isBlank)
        _listenChatGroup.cancel();
      chatGroup.photoUrl = partner.photoUrl;
      chatGroup.name = partner.displayName;
      message.groupID = chatGroup.id;
      chatNewUser.value = false;
      if (_eventsSubscription == null || _eventsSubscription.isBlank) {
        startListenToChange();
      }
    }
    bool sent = await MessageService.instance.sendMessage(message);
    if (scrollController.hasClients)
      scrollController.animateTo(
        0.0,
        duration: Duration(milliseconds: 800),
        curve: Curves.fastOutSlowIn,
      );
  }

  Future getMessage() async {
    messages.value = await MessageService.instance.getMessages(chatGroup);
    isLoading.value = false;
    if (scrollController.hasClients)
      scrollController.animateTo(
        0.0,
        duration: Duration(milliseconds: 800),
        curve: Curves.fastOutSlowIn,
      );
  }

  Future<bool> isNewChatUser() async {
    isLoading.value = true;
    List<ChatGroup> chatGroups =
        await FirestoreService.instance.getChatGroups(mainUser.uid);
    for (var _chatGroup in chatGroups) {
      if (_chatGroup.peopleID.length == 2) {
        if ((mainUser.uid == partner.uid &&
                _chatGroup.peopleID[0] == _chatGroup.peopleID[1] &&
                _chatGroup.peopleID[1] == mainUser.uid) ||
            ((mainUser.uid != partner.uid &&
                _chatGroup.peopleID.contains(mainUser.uid) &&
                _chatGroup.peopleID.contains(partner.uid)))) {
          print(_chatGroup.peopleID[0] + " " + _chatGroup.peopleID[1]);
          chatNewUser.value = false;
          isLoading.value = false;
          chatGroup = _chatGroup;
          await getMessage();
          startListenToChange();
          return chatNewUser.value;
        }
      }
    }
    chatNewUser.value = true;
    startListenStartConversation();
    isLoading.value = false;
    return chatNewUser.value;
  }

  bool isLastRight(int index) {
    if ((index > 0 &&
            messages != null &&
            messages[index - 1].senderUID != mainUser.uid) ||
        index == 0) {
      return true;
    } else {
      return false;
    }
  }

  bool isLastLeft(int index) {
    if ((index > 0 &&
            messages != null &&
            messages[index - 1].senderUID == mainUser.uid) ||
        index == 0) {
      return true;
    } else {
      return false;
    }
  }

  Future sendImage(String _imageURL) async {
    Message message = Message(
        mainUser.uid,
        (chatNewUser.value) ? "" : chatGroup.id,
        _imageURL,
        DateTime.now().millisecondsSinceEpoch,
        1);
    if (message.groupID == "" || message.groupID == null) {
      chatGroup = await FirestoreService.instance
          .createChatGroup([mainUser.uid, partner.uid]);
      if (_listenChatGroup != null && !_listenChatGroup.isBlank)
        _listenChatGroup.cancel();
      chatGroup.photoUrl = partner.photoUrl;
      chatGroup.name = partner.displayName;
      message.groupID = chatGroup.id;
      chatNewUser.value = false;
      if (_eventsSubscription == null && _eventsSubscription.isBlank)
        startListenToChange();
    }
    await MessageService.instance.sendMessage(message);
    scrollController.animateTo(
      0.0,
      duration: Duration(milliseconds: 800),
      curve: Curves.fastOutSlowIn,
    );
  }

  Future getImage() async {
    ImagePicker imagePicker = ImagePicker();
    PickedFile pickedFile =
        await imagePicker.getImage(source: ImageSource.gallery);
    if (pickedFile == null) {
      Fluttertoast.showToast(
          msg: "Cancel sending image..",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER);
      return;
    }
    File file = File(pickedFile.path);
    if (file != null) {
      await StorageService.instance.uploadFile(file);
    } else
      Fluttertoast.showToast(
          msg: "Something gone wrong...",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER);
  }

  bool needShowTime(int index) {
    if (index == messages.length - 1) return true;
    final time = DateTime.fromMillisecondsSinceEpoch(messages[index].timeStamp)
        .toLocal();
    final lastTime =
        DateTime.fromMillisecondsSinceEpoch(messages[index + 1].timeStamp)
            .toLocal();
    if (time.difference(lastTime).inMinutes > 15) return true;
    return false;
  }

  static String getTime(int timeStamp) {
    final now = DateTime.now().toLocal();
    final time = DateTime.fromMillisecondsSinceEpoch(timeStamp).toLocal();
    final timeDistance = now.difference(time);
    if (timeDistance.inHours < 24) return DateFormat("HH:mm").format(time);
    if (timeDistance.inDays < 7) return DateFormat("HH:mm, EE dd").format(time);
    if (timeDistance.inDays < 365)
      return DateFormat("HH:mm dd/MM").format(time);
    return DateFormat("HH:mm, dd/MM/yyyy").format(time);
  }

  @override
  void onClose() {
    if (_eventsSubscription != null && !_eventsSubscription.isBlank)
      _eventsSubscription.cancel();
    if (_listenChatGroup != null && !_listenChatGroup.isBlank)
      _listenChatGroup.cancel();
    scrollController.dispose();
    super.onClose();
  }
}
