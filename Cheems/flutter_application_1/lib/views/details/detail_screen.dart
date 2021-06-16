import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/readingController.dart';
import 'package:flutter_application_1/models/News.dart';
import 'package:flutter_application_1/views/widgets.dart';
import 'package:get/get.dart';

import 'components/body.dart';

class DetailScreen extends StatefulWidget {

  DetailScreen({Key? key,required News news}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen>  {
  
  late News news;
  final  _readingController = Get.put(ReadingController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Body( product: news,),
    );
  }

  AppBar buildAppBar() {
    /*for (int i = 0; i < favorites.length; i++) {
      if (favorites[i].link == products[idDetal].source) {
        indexFavorite = i;
        break;
      }
    }*///get list favorite
    bool check = true;
    return AppBar(
      centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          (_readingController.news!.imgaeSource == "")? 
          Text(_readingController.news!.source,style: textFieldTextStyle(),):
          Image.network(
            _readingController.news!.imgaeSource,
            height: 25,
            fit: BoxFit.fitWidth,
          ),
          SizedBox(width: 2),
          IconButton(
            icon: Icon(
              (check)
                  ? Icons.favorite
                  : Icons.favorite_border,
              color: Colors.red,
            ),
            onPressed: () {
              
              setState(() {
                check = !check;
              });
            },
          )
        ],
      ),
    );
  }
}
