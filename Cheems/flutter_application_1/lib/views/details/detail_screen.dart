import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_application_1/controllers/AuthenticController.dart';
import 'package:flutter_application_1/controllers/FavoriteController.dart';
import 'package:flutter_application_1/controllers/SettingController.dart';
import 'package:flutter_application_1/controllers/readingController.dart';
import 'package:flutter_application_1/models/News.dart';
import 'package:flutter_application_1/views/details/components/bottom_bar.dart';
import 'package:flutter_application_1/views/details/components/hide_nav_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class DetailScreen extends StatelessWidget {
  late News news;
  DetailScreen({required this.news});
  final _settingController = Get.find<SettingController>();
  final _authenticController = Get.find<AuthenticController>();
  final _readingController = Get.find<ReadingController>();
  final _favoriteController = Get.find<FavoriteController>();

  final HideNavBar hiding = HideNavBar();
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
            bottomNavigationBar: ValueListenableBuilder(
              valueListenable: hiding.visible,
              builder: (context, bool value, child) => AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  height: value ? kBottomNavigationBarHeight : 0.0,
                  child: buildBottomBar(_settingController.kBackgroundColor,
                      _settingController.kPrimaryColor.value)),
            ))
        : Scaffold(
            backgroundColor:
                _settingController.kPrimaryColor.value.withOpacity(.1),
            body: Center(
              child: Text("Can't load data from server. Please try again."),
            ),
          ));
  }

  AppBar buildAppBar(BuildContext context, News news) {
    _favoriteController.check.value = _favoriteController.checkNew(news.id);
    return AppBar(
      backgroundColor: _settingController.kPrimaryColor.value,
      centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          (_readingController.news!.imageSource == "")
              ? Text(
                  _readingController.news!.source,
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: _settingController.textSize.value + 2),
                )
              : Image.network(
                  _readingController.news!.imageSource,
                  height: 25,
                  fit: BoxFit.fitWidth,
                ),
          SizedBox(width: 2),
          GestureDetector(
            child: Container(
              height: 30,
              width: 30,
              child: (_favoriteController.check.value)
                  ? SvgPicture.asset("assets/icons/favourite_selected.svg")
                  : SvgPicture.asset("assets/icons/favourite.svg"),
            ),
            onTap: () async {
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
          ),
        ],
      ),
    );
  }

  Widget tagView() {
    //need fixed
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(Icons.category_outlined),
          Container(
            padding: EdgeInsets.all(3),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.grey[300]),
            child: Text(
              _readingController.news!.tag[0],
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: _settingController.textSize.value),
            ),
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }

  Widget newsView() {
    return ListView(
        controller: hiding.controller,
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        shrinkWrap: true,
        children: [
          Text(_readingController.news!.title,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black54, fontSize: 30)),
          SizedBox(
            height: 10,
          ),
          tagView(),
          Row(
            //date
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(_readingController.news!.dateCreate,
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: _settingController.textSize.value)),
              SizedBox(
                width: 10,
              ),
            ],
          ),
          Container(
            //decription
            padding: EdgeInsets.all(8),
            child: Text(
              _readingController.news!.decription,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 12 + 8,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 10,
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
                  SizedBox(
                    height: 10,
                  ),
                  Obx(
                    () => Text(
                      _readingController.news!.body[index],
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: _settingController.textSize.value + 4,
                          height: 1.5),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  )
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
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: _settingController.textSize.value + 2),
              ),
              SizedBox(
                width: 10,
              ),
            ],
          ),
        ]);
  }
}
