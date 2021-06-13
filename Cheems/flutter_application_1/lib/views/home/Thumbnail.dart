import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/News.dart';
import 'package:flutter_application_1/views/widgets.dart';

class ThumbnailView extends StatelessWidget {
  late Thumbnail? news;
  ThumbnailView(this.news);
  @override
  Widget build(BuildContext context) {
    return (this.news != null) ? 
      Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Text(news!.title,style: textFieldTextStyle(),),
            SizedBox(height: 20),
            Image.network(news!.imageLink[0],width: 50,height: 50,),
            SizedBox(height: 20,),
            Text(news!.decription!,style: textFieldTextStyle(),),
          ],
        ),
      )
      :Container();
  }
}