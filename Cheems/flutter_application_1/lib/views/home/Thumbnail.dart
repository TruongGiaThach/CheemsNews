import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/News.dart';
import 'package:flutter_application_1/services/AuthenticService.dart';
import 'package:flutter_application_1/views/readingPage/readingPage.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get.dart';

class ThumbnailView extends StatelessWidget {
  late Thumbnail? news;
  String accessToken = AuthenticService.instance.ggAccessToken;
  ThumbnailView(this.news);
  @override
  Widget build(BuildContext context) {
    return (this.news != null)
        ? Container(
            margin: EdgeInsets.only(left: 3.0, bottom: 3),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: GestureDetector(
              onTap: () => {
                if (news != null) Get.to(ReadingPage(this.news!.id)),
              },
              child: Row(children: [
                /*Image.network(
                  news!.imageLink[0],
                  width: 100,
                  height: 80,
                ),*/
                Container(
                  width: 100,
                  height: 80,
                  child: CachedNetworkImage(
                    imageUrl: news!.imageLink[0],
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                            ),
                      ),
                    ),
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Text(
                    news!.title,
                    style: TextStyle(color: Colors.black87, fontSize: 18),
                  ),
                )
              ]),
            ))
        : Container();
  }
}
