class MyUser {
  String uid;
  String displayName;
  String photoUrl;
  String email;
  late int typeAccount;
  MyUser(this.uid, this.email, this.displayName, this.photoUrl);
  factory MyUser.fromJson(Map<String, dynamic> result) {
    return MyUser(
      result['id'],
      result['email'],
      result['displayName'],
      result['photoUrl'],
    );
  }
}
