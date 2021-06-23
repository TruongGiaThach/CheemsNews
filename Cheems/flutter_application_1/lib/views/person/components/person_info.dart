import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/SettingController.dart';
import 'package:get/get.dart';

final _settingController = Get.find<SettingController>();

class PersonInfo extends StatefulWidget {
  const PersonInfo({
    Key? key,
  }) : super(key: key);

  @override
  _PersonInfoState createState() => _PersonInfoState();
}

class _PersonInfoState extends State<PersonInfo> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: <Widget>[
            Text(
              "Thông tin cá Nhân",
              style: TextStyle(
                  color: Colors.black54, fontSize: _settingController.textSize),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: <Widget>[
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.read_more),
            ),
            Text(
              "Họ Tên",
              style: TextStyle(fontSize: _settingController.textSize),
            ),
            Spacer(),
            Text(
              "Trần Anh Tú",
              style: TextStyle(
                  color: Colors.black, fontSize: _settingController.textSize),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.read_more),
            ),
            Text(
              "Ngày Sinh",
              style: TextStyle(fontSize: _settingController.textSize),
            ),
            Spacer(),
            Text(
              "19 02 2001",
              style: TextStyle(
                  color: Colors.black, fontSize: _settingController.textSize),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.read_more),
            ),
            Text(
              "Số Điện Thoại",
              style: TextStyle(fontSize: _settingController.textSize),
            ),
            Spacer(),
            Text(
              "+84 986 653 409",
              style: TextStyle(
                  color: Colors.black, fontSize: _settingController.textSize),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.read_more),
            ),
            Text(
              "Địa chỉ email",
              style: TextStyle(fontSize: _settingController.textSize),
            ),
            Spacer(),
            Text(
              "19522456@gm.uit.edu.vn",
              style: TextStyle(
                  color: Colors.black, fontSize: _settingController.textSize),
            ),
          ],
        ),
      ],
    );
  }
}
