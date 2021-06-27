import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/SettingController.dart';
import 'package:flutter_application_1/models/News.dart';
import 'package:flutter_application_1/views/details/detail_screen.dart';
import 'package:get/get.dart';

import '../widgets.dart';

// ignore: non_constant_identifier_names
InkWell FavItem(BuildContext context, News thumb) {
  return InkWell(
      onTap: () {
        Get.to(() => DetailScreen(
              news: thumb,
            ));
      },
     // onLongPress:  ,
      child: Padding(
        padding:
            const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8, right: 4),
        child: Row(children: [
          Container(
            height: MediaQuery.of(context).size.height / 8,
            width: MediaQuery.of(context).size.height / 8,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
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
                        height: 10,
                        width: 10,
                        child: CircularProgressIndicator(
                            value: downloadProgress.progress)),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Text(
              '${thumb.title}\n\n',
              style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold, fontSize: SettingController().textSize.value  + 3),
              maxLines: 4,
            ),
          ),
        ]),
      ));
}
