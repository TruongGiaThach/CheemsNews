import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/readingController.dart';
import 'package:flutter_application_1/views/widgets.dart';

import 'package:get/get.dart';

class ReadingPage extends StatelessWidget {
  late String iD;
  late var _readingController = Get.put(ReadingController());
  ReadingPage(String id) {
    this.iD = id;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: RefreshIndicator(
      onRefresh: () => _readingController.fletchNews(this.iD),
      child: Obx(() => (_readingController.hasData.isFalse)
          ? ListView(
              physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              children: [
                Container(
                    alignment: Alignment.center,
                    child: Text("There is no data. Scroll to reload")),
              ],
            )
          : newsView()),
    ));
  }

  Widget tagView() { //need fixed
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
                  if (_readingController.news!.imageLink.length > index - 1)
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
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
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
