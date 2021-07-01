import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/AuthenticController.dart';
import 'package:flutter_application_1/controllers/FavoriteController.dart';
import 'package:flutter_application_1/controllers/HomeController.dart';
import 'package:flutter_application_1/controllers/SettingController.dart';
import 'package:flutter_application_1/views/home/components/typeNewsViews/listTypeViews.dart';
import 'package:flutter_application_1/views/home/components/typeNewsViews/typeNewsViews.dart';
import 'package:get/get.dart';
import 'components/home_body/home_body.dart';

class HomeLink extends StatelessWidget {
  HomeLink({
    Key? key,
  }) : super(key: key);
  final _settingController = Get.find<SettingController>();

  final _authenticController = Get.find<AuthenticController>();
  final _homeController = Get.find<HomeController>();
  final _favoriteController = Get.find<FavoriteController>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder(
      future: Future.wait([
        _homeController.initialize(),
        (_authenticController.currentUser != null
            ? _favoriteController
                .initListFav(_authenticController.currentUser!.uid)
            : _favoriteController.initListFav(""))
      ]),
      builder: (context, snapshot) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            elevation: 2,
            // ignore: deprecated_member_use
            leading: FlatButton(
              child: Icon(
                Icons.home,
                color: Colors.white,
              ),
              onPressed: () {
                _homeController.typeIndex.value = 0;
              },
            ),
            backgroundColor: _settingController.kPrimaryColor.value,

            actions: [
              Container(
                height: 20,
                width: size.width * .85,
                child: ListView(
                  children: _initListTitle(),
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ],
          ),
          body: Obx(() => (_homeController.typeIndex.value == 0)
              ? BodyHome()
              : TypeNewsViews(
                  typeNews: _homeController
                      .listType[(_homeController.typeIndex.value - 1)].name)),
        );
      },
    );
  }

  List<NavTitle> _initListTitle() {
    List<NavTitle> tmp = [];
    for (int i = 0; i < _homeController.listType.length; i++) {
      tmp.add(new NavTitle(
        text: i,
      ));
    }
    return tmp;
  }
}
