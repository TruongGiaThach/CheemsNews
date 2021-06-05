import 'package:demo_chat_app/models/Message.dart';

class ChatGroup {
  List<String> peopleID = [];
  String name = "";
  String id = "";
  Message lastMessage;
  String photoUrl = "";
  bool seen = true;
  ChatGroup(this.id, this.name, this.peopleID);
}
