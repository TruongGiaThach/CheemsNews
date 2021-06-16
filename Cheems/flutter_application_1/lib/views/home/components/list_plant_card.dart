import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/GetNewsController.dart';
import 'package:flutter_application_1/models/News.dart';
import 'package:flutter_application_1/views/details/detail_screen.dart';
import 'package:get/get.dart';

import '../../../constants.dart';

class ListPlantCard extends StatelessWidget {
  final String topic;

  ListPlantCard({Key? key, required this.topic}) : super(key: key);

  final controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    //Future<List<News>> productwithtopic =
    //    FirestoreService.instance.getLimitNewsWithTag(topic);
    return FutureBuilder(
        future: controller.getListThumbWithTopic(topic,4),
        builder: (context, AsyncSnapshot<List<News>> snapshot) {
          // Check for errors
          if (snapshot.hasError) {
            print("error when load " + topic);
          }
          // Once complete, show your application
          if (snapshot.connectionState == ConnectionState.done) 
            return Padding(
                padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
                child: Container(
                    height: 300,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: (snapshot.data == null)? 0 : snapshot.data!.length,
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
    Size size = MediaQuery.of(context).size;

    return InkWell(
      onTap: () {
        Get.to(DetailScreen(
          news: thumb,
        ));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding,
        ),
        child: Container(
          width: size.width * 0.7,
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
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
                        placeholder: (context, url) => Container(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                
              ),
              Container(
                padding: EdgeInsets.all(kDefaultPadding / 2),
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
                        color: kPrimaryColor.withOpacity(.23),
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
                        
                      Image.network(thumb.imageSource,height: 20,),
                        Spacer(),
                        Text(thumb.dateCreate)
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
