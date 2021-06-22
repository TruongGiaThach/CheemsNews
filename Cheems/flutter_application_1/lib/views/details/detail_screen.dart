import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/AuthenticController.dart';
import 'package:flutter_application_1/controllers/FavoriteController.dart';
import 'package:flutter_application_1/controllers/readingController.dart';
import 'package:flutter_application_1/models/News.dart';
import 'package:flutter_application_1/views/widgets.dart';
import 'package:get/get.dart';

import '../../constants.dart';

class DetailScreen extends StatelessWidget {
  late News news;
  DetailScreen({required this.news});
  final _authenticController = Get.find<AuthenticController>();
  final _readingController = Get.find<ReadingController>();
  final _favoriteController = Get.find<FavoriteController>();

  @override
  Widget build(BuildContext context) {
    _readingController.news = this.news;
    _readingController.hasData.value = true;
    return Obx(() => (_readingController.hasData.isTrue)
        ? Scaffold(
            appBar: buildAppBar(context, news),
            body: RefreshIndicator(
                onRefresh: () => _readingController.fletchNews(news.id),
                child: newsView()),
          )
        : Scaffold(
            body: Center(
              child: Text("Can't load data from server. Please try again."),
            ),
          ));
  }

  AppBar buildAppBar(BuildContext context, News news) {
    /*for (int i = 0; i < favorites.length; i++) {
      if (favorites[i].link == products[idDetal].source) {
        indexFavorite = i;
        break;
      }
    }*/ //get list favorite
    _favoriteController.check.value = _favoriteController.checkNew(news.id);
    return AppBar(
      backgroundColor: kPrimaryColor,
      centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          (_readingController.news!.imageSource == "")
              ? Text(
                  _readingController.news!.source,
                  style: textFieldTextStyle(),
                )
              : Image.network(
                  _readingController.news!.imageSource,
                  height: 25,
                  fit: BoxFit.fitWidth,
                ),
          SizedBox(width: 2),
          IconButton(
            icon: Icon(
              (_favoriteController.check.value)
                  ? Icons.favorite
                  : Icons.favorite_border,
              color: Colors.red,
            ),
            onPressed: () async {
              if (_authenticController.currentUser != null) {
                if (_favoriteController.check.value == false) {
                  await _favoriteController.addNewsToListFav(
                      _authenticController.currentUser, news);
                  _favoriteController.check.value = true;
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('new add to favorites'),
                    duration: Duration(seconds: 1),
                  ));
                } else {
                  await _favoriteController.deleteNewsFromListFav(
                      _authenticController.currentUser, news);
                  _favoriteController.check.value = false;
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('new remove form favorites'),
                    duration: Duration(seconds: 1),
                  ));
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('login require'),
                  duration: Duration(seconds: 1),
                ));
              }
            },
          )
        ],
      ),
    );
  }

  Widget tagView() {
    //need fixed
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(Icons.category_outlined),
        Container(
          padding: EdgeInsets.all(3),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), color: Colors.grey),
          child: Text(
            _readingController.news!.tag[0],
            style: minimzeTextStyle(),
          ),
        ),
        SizedBox(
          width: 10,
        ),
      ],
    );
  }

  Widget newsView() {
    return ListView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        shrinkWrap: true,
        children: [
          Container(
            //title
            child: Expanded(
                child: Text(_readingController.news!.title,
                    textAlign: TextAlign.center, style: newsTiltleTextStyle())),
          ),
          SizedBox(
            height: 10,
          ),
          tagView(),
          Row(
            //date
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                _readingController.news!.dateCreate,
                style: minimzeTextStyle(),
              ),
              SizedBox(
                width: 10,
              ),
            ],
          ),
          Container(
            //body news

            padding: EdgeInsets.all(8),
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: _readingController.news!.body.length,
              itemBuilder: (context, index) => Column(
                children: [
                  if (_readingController.news!.imageLink.length > index)
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 150,
                      child: CachedNetworkImage(
                        imageUrl: _readingController.news!.imageLink[index],
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        placeholder: (context, url) => Container(
                            height: 50,
                            width: 50,
                            child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    )
                  else
                    Container(),
                  Text(
                    _readingController.news!.body[index],
                    style: newsBodyTextStyle(),
                  ),
                ],
              ),
            ),
          ),
          Row(
            //author
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                _readingController.news!.author,
                style: textFieldTextStyle(),
              ),
              SizedBox(
                width: 10,
              ),
            ],
          ),
          Row(
            //source
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                _readingController.news!.source,
                style: textFieldTextStyle(),
              ),
              SizedBox(
                width: 10,
              ),
            ],
          ),
        ]);
  }
}
