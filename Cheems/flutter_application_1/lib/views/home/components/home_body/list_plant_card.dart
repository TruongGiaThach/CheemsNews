import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/HomeController.dart';
import 'package:flutter_application_1/controllers/SettingController.dart';
import 'package:flutter_application_1/models/News.dart';
import 'package:flutter_application_1/views/details/detail_screen.dart';
import 'package:get/get.dart';

final _settingController = Get.find<SettingController>();

class ListPlantCard extends StatelessWidget {
  final String topic;

  ListPlantCard({Key? key, required this.topic}) : super(key: key);

  final controller = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: controller.getListThumbWithTopic(topic, 4),
        builder: (context, AsyncSnapshot<List<News>> snapshot) {
          // Check for errors
          if (snapshot.hasError) {
            print("error when load " + topic);
          }
          // Once complete, show your application
          if (snapshot.connectionState == ConnectionState.done)
            return Padding(
                padding: EdgeInsets.symmetric(
                    vertical: _settingController.kDefaultPadding),
                child: Container(
                    height: 275,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount:
                          (snapshot.data == null) ? 0 : snapshot.data!.length,
                      itemBuilder: (context, index) => buildCard(
                        context,
                        snapshot.data![index],
                      ),
                    )));
          // Otherwise, show something whilst waiting for initialization to complete
          return CircularProgressIndicator();
        });
  }

  InkWell buildCard(BuildContext context, News thumb) {

    return InkWell(
      onTap: () {
        Get.to(() => DetailScreen(
              news: thumb,
            ));
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: _settingController.kDefaultPadding,
        ),
        child: Container(
          width: 250,
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                child: CachedNetworkImage(
                  imageUrl: thumb.imageLink.first,
                  imageBuilder: (context, imageProvider) => Container(
                    height: 150,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(
                    child: CircularProgressIndicator(
                        value: downloadProgress.progress),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              Obx(() => Container(
                    padding:
                        EdgeInsets.all(_settingController.kDefaultPadding / 2),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 10),
                            blurRadius: 50,
                            color: _settingController.kPrimaryColor.value
                                .withOpacity(.23),
                          )
                        ]),
                    child: Column(
                      children: [
                        Text(
                          '${thumb.title}\n\n',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                          maxLines: 2,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Image.network(
                                thumb.imageSource,
                                height: 20,
                              ),
                            ),
                            Spacer(),
                            Expanded(child: Text(thumb.dateCreate))
                          ],
                        )
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
