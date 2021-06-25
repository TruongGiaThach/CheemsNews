

class Comments{
  late String userName;
  late String userImage;
  late String body;
  late DateTime time;

   Comments(this.userName,this.userImage,this.body,this.time);
  factory Comments.fromJson(Map<String, dynamic> result) {
    return Comments(
      result['username'],
      result['userimage'],
      result['body'],
      DateTime.parse(result['time'])
      
    );
  }
  
}