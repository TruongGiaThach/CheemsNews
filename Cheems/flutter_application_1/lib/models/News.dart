import 'package:flutter_application_1/models/Comment.dart';

class News {
  late String id;
  late List<String> body;
  late String dateCreate;
  late List<String> imageLink;
  late String numOfLike;
  late String source;
  late String imgaeSource;
  late List<String> tag;
  late String title;
  late List<Comments> cmts;
  late String author;

  News(this.id,this.body,this.dateCreate,this.imageLink,this.numOfLike,this.source,this.tag,this.title,this.author,this.imgaeSource);
  factory News.fromJson(Map<String,dynamic> result){
    return News(
      result['ID'],
      List.castFrom(result['body'] as List<dynamic>),
      result['dateCreate'],
      List.castFrom(result['image'] as List<dynamic>),
      result['numOfLike'],
      result['source'],
      List.castFrom(result['tag'] as List<dynamic>),
      result['title'],
      result['author'],
      result['imageSource']
    );
  }


}
