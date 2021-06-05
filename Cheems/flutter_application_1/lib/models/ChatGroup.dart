import 'package:flutter_application_1/models/Message.dart';

class ChatGroup {
  List<String> peopleID = [];
  String name = "";
  String id = "";
  late Message lastMessage;
  String photoUrl = "";
  bool seen = true;
  ChatGroup(this.id, this.name, this.peopleID);
}
