class myUser {
  String uid;
  String displayName;
  String photoUrl;
  String email;
  late int typeAccount;
 myUser(this.uid, this.email, this.displayName, this.photoUrl);
  factory myUser.fromJson(Map<String, dynamic> result) {
    return myUser(
      result['id'],
      result['email'],
      result['displayName'],
      result['photoUrl'],
    );
  }
}
