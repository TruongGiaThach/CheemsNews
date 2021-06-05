class Message {
  String senderUID;
  String content;
  int timeStamp;
  String groupID;
  int type;
  Message(
      this.senderUID, this.groupID, this.content, this.timeStamp, this.type);
}
