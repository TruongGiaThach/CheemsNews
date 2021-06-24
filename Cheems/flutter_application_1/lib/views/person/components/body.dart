import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/AuthenticController.dart';
import 'package:flutter_application_1/controllers/SettingController.dart';
import 'package:get/get.dart';
import 'color_dot.dart';
import 'person_avatar.dart';
import 'person_info.dart';

final _settingController = Get.find<SettingController>();
var _authenticController = Get.find<AuthenticController>();

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          color: _settingController.kPrimaryColor.value.withOpacity(.1),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 40),
                PersonAvatar(),
                SizedBox(height: 20),
                Text(
                  _authenticController.currentUser != null
                      ? _authenticController.currentUser!.displayName
                      : 'GUEST ACCOUNT',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(_settingController.kDefaultPadding),
                  child: Obx(() => Column(
                        children: [
                          _authenticController.currentUser != null
                              ? PersonInfo()
                              : SizedBox(height: 0),
                          SizedBox(height: 10),
                          Row(
                            children: <Widget>[
                              Text(
                                "Tùy chọn",
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: _settingController.textSize.value,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          FontFamilySetting(),
                          FontSizeSetting(),
                          Row(
                            children: <Widget>[
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.swap_horiz),
                              ),
                              Text(
                                "Màu chủ đề",
                                style: TextStyle(
                                    fontSize:
                                        _settingController.textSize.value),
                              ),
                              Spacer(),
                              Container(
                                width: 120,
                                height: 24,
                                child: ListView.builder(
                                  itemCount: _settingController.kColor.length,
                                  itemBuilder: (context, index) =>
                                      ColorDot(id: index),
                                  scrollDirection: Axis.horizontal,
                                ),
                              ),
                            ],
                          ),
                          /*SizedBox(height: 10),
                          Row(
                            children: <Widget>[
                              Text(
                                "Đăng xuất",
                                style: TextStyle(
                                    fontSize:
                                        _settingController.textSize.value),
                              ),
                              Spacer(),
                              IconButton(
                                  onPressed: () {}, icon: Icon(Icons.logout)),
                            ],
                          )*/
                        ],
                      )),
                )
              ],
            ),
          ),
        ));
  }

  // ignore: non_constant_identifier_names
  Widget FontSizeSetting() {
    return Obx(() => Row(
          children: <Widget>[
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.swap_horiz),
            ),
            Text(
              "Cỡ chữ",
              style: TextStyle(fontSize: _settingController.textSize.value),
            ),
            Spacer(),
            // ignore: deprecated_member_use
            IconButton(
              onPressed: () {
                if (_settingController.textSize > 12)
                  _settingController.textSize -= 1.0;
              },
              icon: Icon(Icons.remove),
            ),
            Text(_settingController.textSize.toStringAsFixed(0)),
            SizedBox(width: 5),
            IconButton(
              onPressed: () {
                if (_settingController.textSize < 15)
                  _settingController.textSize += 1.0;
              },
              icon: Icon(Icons.add),
            ),
          ],
        ));
  }

  // ignore: non_constant_identifier_names
  Widget FontFamilySetting() {
    return Obx(() => Row(
          children: <Widget>[
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.swap_horiz),
            ),
            Text(
              "Font chữ",
              style: TextStyle(fontSize: _settingController.textSize.value),
            ),
            Spacer(),
            ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: Container(
                height: 25,
                // ignore: deprecated_member_use
                child: Obx(() => FlatButton(
                      color: _settingController.textFont.value == 0
                          ? _settingController.kPrimaryColor.value
                          : null,
                      onPressed: () {
                        _settingController.textFont.value = 0;
                      },
                      child: Text(
                        "Rubik",
                        style: TextStyle(
                          fontSize: _settingController.textSize.value,
                          // ignore: unrelated_type_equality_checks
                          color: (_settingController.textFont == 0)
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    )),
              ),
            ),
            SizedBox(width: 5),
            ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: Container(
                height: 25,
                // ignore: deprecated_member_use
                child: Obx(() => FlatButton(
                      color: _settingController.textFont.value == 1
                          ? _settingController.kPrimaryColor.value
                          : null,
                      onPressed: () {
                        _settingController.textFont.value = 1;
                      },
                      child: Text(
                        "Bookerly",
                        style: TextStyle(
                          fontSize: _settingController.textSize.value,
                          // ignore: unrelated_type_equality_checks
                          color: _settingController.textFont == 1
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    )),
              ),
            ),
          ],
        ));
  }
}
