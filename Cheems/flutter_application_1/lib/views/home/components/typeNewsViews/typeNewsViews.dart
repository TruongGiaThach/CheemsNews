import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/HomeController.dart';
import 'package:flutter_application_1/models/News.dart';
import 'package:flutter_application_1/views/details/detail_screen.dart';
import 'package:flutter_application_1/views/widgets.dart';
import 'package:get/get.dart';

import '../../../../constants.dart';

class TypeNewsViews extends StatelessWidget {
  TypeNewsViews({Key? key, required this.typeNews}) : super(key: key);

  late String typeNews;
  final controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: controller.getListThumbWithTopic(this.typeNews, 10),
        builder: (context, AsyncSnapshot<List<News>> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                  "There are some error when load this topic, please try again."),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return (snapshot.hasData)
                ? ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return buildItem(context, snapshot.data![index]);
                    })
                : Center(
                    child: Text("Can't find news matching with this topic"));
          }
          ;
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  InkWell buildItem(BuildContext context, News thumb) {
    return InkWell(
        onTap: () {
          Get.to(() => DetailScreen(
                news: thumb,
              ));
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0,top: 8.0,bottom: 8,right: 4),
          child: Row(
              
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 7,
                  width: MediaQuery.of(context).size.height / 7,
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
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => Container(
                              height: 20,
                              width: 20,
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
                  
                  child: Column(
                    children: [
                      Text(
                        '${thumb.title}\n\n',
                        style: titleTextFieldTextStyle(),
                        maxLines: 4,
                        
                      ),
                      
                      Row (
                        children: [
                          
                          Expanded(
                            child: Image.network(
                              thumb.imageSource,
                              height: 15,
                            ),
                          ),
                          Spacer(),
                          Expanded(child: Text(thumb.dateCreate))
                        ],
                      )
                    ],
                  ),
                ),
              ]),
        ));
  }
}
