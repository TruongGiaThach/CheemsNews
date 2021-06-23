import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/AuthenticController.dart';
import 'package:flutter_application_1/controllers/FavoriteController.dart';
import 'package:flutter_application_1/models/News.dart';
import 'package:flutter_application_1/views/favorite/fav_item_view.dart';
import 'package:get/get.dart';

class FavoriteLink extends StatelessWidget {
  FavoriteLink({Key? key}) : super(key: key);

  final controller = Get.find<FavoriteController>();
  final authController = Get.find<AuthenticController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Obx(() => (!authController.isGuest.value)
            ? FutureBuilder(
                future: controller.loadListFav(authController.currentUser!.uid),
                builder: (context, AsyncSnapshot<List<News>> snapshot) {
                  if (snapshot.hasError) {
                    return Container(
                      child: Center(
                        child: Text(
                            "There are some error when load your favorite list"),
                      ),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.done) 
                      if (snapshot.hasData) 
                        if (snapshot.data!.length != 0) {
                          return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return FavItem(context, snapshot.data![index]);
                            }); // show list news
                        } else
                            return Container(
                                child: Center(
                              child: Text("You don't have any news in list"),
                            ));
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              )
            : Container(child: Center(child: Text("Button : Sign In now")))));
  }
}
