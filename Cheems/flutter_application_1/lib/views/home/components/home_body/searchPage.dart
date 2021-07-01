import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/HomeController.dart';
import 'package:flutter_application_1/controllers/SearchController.dart';
import 'package:flutter_application_1/controllers/SettingController.dart';
import 'package:get/get.dart';

import '../../../widgets.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _searchController = Get.put(SearchController());

  ScrollController _controller = ScrollController();
  final _settingController = Get.find<SettingController>();
  final homecontroller = Get.find<HomeController>();
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Obx(() => Column(
                children: [
                  FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 10.0, 0, 0),
                          child: Container(
                            width: size.width,
                            margin: EdgeInsets.only(
                                left: _settingController.kDefaultPadding),
                            height: 54,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                      offset: Offset(0, 10),
                                      blurRadius: 50,
                                      color: _settingController
                                          .kPrimaryColor.value
                                          .withOpacity(.23)),
                                ]),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Obx(() => TextField(
                                    controller: _textController,
                                    onChanged: (text) async {
                                      _searchController.searchLine.value = text;
                                      _searchController.searchResult.value =
                                          await homecontroller
                                              .getListThumbWithName(text);
                                    },
                                    onTap: () {},
                                    decoration: InputDecoration(
                                        hintText: "Tìm kiếm",
                                        hintStyle: TextStyle(
                                          color: _settingController
                                              .kPrimaryColor.value
                                              .withOpacity(0.5),
                                        ),
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        suffixIcon: _searchController
                                                .searchLine.value.isNotEmpty
                                            ? IconButton(
                                                icon: Icon(Icons.close),
                                                onPressed: () {
                                                  _searchController
                                                      .searchLine.value = "";
                                                  _textController.text = "";
                                                },
                                              )
                                            : Icon(Icons.search)),
                                    style: TextStyle(
                                        color: _settingController
                                            .kPrimaryColor.value),
                                  )),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 8.0, 0),
                          height: 54,
                          child: TextButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: Text(
                                'cancel',
                                style: TextStyle(fontSize: 18),
                              )),
                        )
                      ],
                    ),
                  ),
                  _searchController.searchLine.value.isEmpty
                      ? Expanded(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            height: size.height - 78,
                            child: FittedBox(
                              child: Opacity(
                                  opacity: 0.5,
                                  child: Image.asset(
                                      "assets/images/tenor (1).gif")),
                              fit: BoxFit.fill,
                            ),
                          ),
                        )
                      : Stack(
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(10),
                                height: size.height - 78,
                                color: Colors.white,
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(10),
                                height: size.height - 78,
                                width: size.width,
                                child: ListView.builder(
                                  controller: _controller,
                                  itemCount:
                                      _searchController.searchResult.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      leading: _searchController
                                                  .searchResult.value[index] !=
                                              null
                                          ? Image.network(
                                              _searchController.searchResult
                                                  .value[index].imageLink.first,
                                              fit: BoxFit.cover,
                                              height: 60,
                                              width: 60,
                                            )
                                          : Container(
                                              height: 60,
                                              width: 60,
                                              child: loadingWiget()),
                                      title: Text(_searchController
                                          .searchResult.value[index].title),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        )
                ],
              )),
        ));
  }
}
