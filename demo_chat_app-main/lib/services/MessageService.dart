import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_chat_app/models/ChatGroup.dart';
import 'package:demo_chat_app/models/Message.dart';

class MessageService {
  MessageService._privateConstructor();
  static final MessageService instance = MessageService._privateConstructor();

  final FirebaseFirestore database = FirebaseFirestore.instance;

  Future<bool> sendMessage(Message message) async {
    await database.collection('messages').doc().set({
      'content': message.content,
      'groupId': message.groupID,
      'senderUid': message.senderUID,
      'timeStamp': message.timeStamp,
      'type': message.type,
    }).onError((_, __) {
      print("error");
      return false;
    });
    return true;
  }

  Message _getMessageFromRaw(Map<String, dynamic> result) {
    return Message(
      result['senderUid'],
      result['groupId'],
      result['content'],
      result['timeStamp'],
      result['type'],
    );
  }

  Future<List<Message>> getMessages(ChatGroup chatGroup) async {
    List<Message> messages = [];
    await database
        .collection('messages')
        .where('groupId', isEqualTo: chatGroup.id)
        .orderBy('timeStamp', descending: true)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        messages.add(_getMessageFromRaw(element.data()));
      });
    });
    return messages;
  }

  Future<Message> getLastMessage(String chatGroupID) async {
    Message msg;
    await database
        .collection("messages")
        .where('groupId', isEqualTo: chatGroupID)
        .orderBy('timeStamp', descending: true)
        .limit(1)
        .get()
        .then((value) {
      msg = _getMessageFromRaw(value.docs[0].data());
    });
    return msg;
  }
}
