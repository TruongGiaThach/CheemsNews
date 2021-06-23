import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/SettingController.dart';
import 'package:flutter_application_1/constants.dart';
import 'package:get/get.dart';
import 'color_dot.dart';
import 'person_avatar.dart';
import 'person_info.dart';

final _settingController = Get.find<SettingController>();

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: kPrimaryColor.withOpacity(.1),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 40),
            PersonAvatar(),
            SizedBox(height: 20),
            Text(
              "Trần Anh Tú",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w600,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(kDefaultPadding),
              child: Column(
                children: [
                  PersonInfo(),
                  SizedBox(height: 10),
                  Row(
                    children: <Widget>[
                      Text(
                        "Tùy chọn",
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: _settingController.textSize,
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
                        style: TextStyle(fontSize: _settingController.textSize),
                      ),
                      Spacer(),
                      Container(
                        width: 120,
                        height: 24,
                        child: ListView.builder(
                          itemCount: _settingController.kColor.length,
                          itemBuilder: (context, index) => ColorDot(id: index),
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: <Widget>[
                      Text(
                        "Đăng xuất",
                        style: TextStyle(fontSize: _settingController.textSize),
                      ),
                      Spacer(),
                      IconButton(onPressed: () {}, icon: Icon(Icons.logout)),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Row FontSizeSetting() {
    return Row(
      children: <Widget>[
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.swap_horiz),
        ),
        Text(
          "Cỡ chữ",
          style: TextStyle(fontSize: _settingController.textSize),
        ),
        Spacer(),
        // ignore: deprecated_member_use
        IconButton(
          onPressed: () {
            setState(() {
              if (_settingController.textSize > 12)
                _settingController.textSize -= 1.0;
            });
          },
          icon: Icon(Icons.remove),
        ),
        Text(_settingController.textSize.toStringAsFixed(0)),
        SizedBox(width: 5),
        IconButton(
          onPressed: () {
            setState(() {
              if (_settingController.textSize < 16)
                _settingController.textSize += 1.0;
            });
          },
          icon: Icon(Icons.add),
        ),
      ],
    );
  }

  // ignore: non_constant_identifier_names
  Row FontFamilySetting() {
    return Row(
      children: <Widget>[
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.swap_horiz),
        ),
        Text(
          "Font chữ",
          style: TextStyle(fontSize: _settingController.textSize),
        ),
        Spacer(),
        ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: Container(
            height: 25,
            // ignore: deprecated_member_use
            child: FlatButton(
              color: _settingController.textFont == 0 ? kPrimaryColor : null,
              onPressed: () {
                setState(() {
                  _settingController.textFont = 0;
                });
              },
              child: Text(
                "Rubik",
                style: TextStyle(
                  fontSize: _settingController.textSize,
                  color: _settingController.textFont == 0
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 5),
        ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: Container(
            height: 25,
            // ignore: deprecated_member_use
            child: FlatButton(
              color: _settingController.textFont == 1 ? kPrimaryColor : null,
              onPressed: () {
                setState(() {
                  _settingController.textFont = 1;
                });
              },
              child: Text(
                "Bookerly",
                style: TextStyle(
                  fontSize: _settingController.textSize,
                  color: _settingController.textFont == 1
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
