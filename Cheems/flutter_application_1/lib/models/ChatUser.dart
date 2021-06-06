class ChatUser {
  String uid;
  String displayName;
  String photoUrl;
  String email;
  ChatUser(this.uid, this.email, this.displayName, this.photoUrl);
  factory ChatUser.fromJson(Map<String, dynamic> result) {
    return ChatUser(
      result['id'],
      result['email'],
      result['displayName'],
      result['photoUrl'],
    );
  }
}
