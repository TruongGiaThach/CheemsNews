import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/HomeController.dart';
import 'package:flutter_application_1/controllers/SettingController.dart';
import 'package:flutter_application_1/models/News.dart';
import 'package:flutter_application_1/views/details/detail_screen.dart';
import 'package:flutter_application_1/views/widgets.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class TypeNewsViews extends StatelessWidget {
  TypeNewsViews({Key? key, required this.typeNews}) : super(key: key);

  late String typeNews;
  final controller = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: controller.getListThumbWithTopic(this.typeNews, 0),
        builder: (context, AsyncSnapshot<List<News>> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                  "There are some error when load this topic, please try again."),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return ListView(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                children: [
                  buildFirstItem(context, snapshot.data![0]),
                  ListView.builder(
                      scrollDirection: Axis.vertical,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return buildItem(context, snapshot.data![index]);
                      })
                ],
              );
            } else
              Center(child: Text("Can't find news matching with this topic"));
          }

          return Center(
            child: loadingWiget(),
          );
        });
  }

  Widget buildFirstItem(BuildContext context, News thumb) {
    return GestureDetector(
      onTap: () {
        Get.to(() => DetailScreen(
              news: thumb,
            ));
      },
      child: Stack(
        children: [
          Container(
            height: 200,
            width: MediaQuery.of(context).size.width,
            child: CachedNetworkImage(
              imageUrl: thumb.imageLink.first,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Container(
                      height: 20,
                      width: 20,
                      child: loadingWiget()),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          Positioned(
              left: 0,
              bottom: 0,
              child: Container(
                  padding: EdgeInsets.all(10),
                  color: Colors.black.withOpacity(.5),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          thumb.title,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            thumb.dateCreate,
                            style: TextStyle(color: Colors.white, fontSize: 10),
                          ))
                    ],
                  ))),
        ],
      ),
    );
  }

  InkWell buildItem(BuildContext context, News thumb) {
    return InkWell(
        onTap: () {
          Get.to(() => DetailScreen(
                news: thumb,
              ));
        },
        child: Padding(
          padding:
              const EdgeInsets.only(left: 4.0, top: 8.0, bottom: 8, right: 4),
          child: Row(children: [
            Container(
              height: 100,
              width: 125,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
                child: CachedNetworkImage(
                  imageUrl: thumb.imageLink.first,
                  filterQuality: FilterQuality.none,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Container(
                          height: 20,
                          width: 20,
                          child: loadingWiget()),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    '${thumb.title}\n\n',
                    style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold, fontSize: SettingController().textSize.value  + 3),
                    maxLines: 4,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Image.network(
                          thumb.imageSource,
                          height: 15,
                          alignment: Alignment.centerLeft,
                        ),
                      ),
                      Expanded(
                          child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(thumb.dateCreate)))
                    ],
                  )
                ],
              ),
            ),
          ]),
        ));
  }
}
