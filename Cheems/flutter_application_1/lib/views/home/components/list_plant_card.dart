import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/GetNewsController.dart';
import 'package:flutter_application_1/models/News.dart';
import 'package:flutter_application_1/services/FirestoreService.dart';
import 'package:flutter_application_1/views/details/detail_screen.dart';
import 'package:get/get.dart';

import '../../../constants.dart';

class ListPlantCard extends StatelessWidget {
  final String topic;

  ListPlantCard({Key? key, required this.topic}) : super(key: key);

  final controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    Future<List<News>> productwithtopic =
        FirestoreService.instance.getLimitNewsWithTag(topic);
    return FutureBuilder(
        // Initialize FlutterFire:
        future: FirestoreService.instance.getLimitNewsWithTag(topic),
        builder: (context, AsyncSnapshot<List<News>> snapshot) {
          // Check for errors
          if (snapshot.hasError) {
            print("errro");
          }
          // Once complete, show your application
          if (snapshot.connectionState == ConnectionState.done) 
            return Padding(
                padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
                child: Container(
                    height: 300,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.length,
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
                child: Image.network(
                  thumb.imageLink[0],
                  width: size.width * 0.7,
                  fit: BoxFit.fitWidth,
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
                        Image.network(
                          thumb.imageLink[0],
                          height: 20,
                          fit: BoxFit.fitWidth,
                        ),
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
