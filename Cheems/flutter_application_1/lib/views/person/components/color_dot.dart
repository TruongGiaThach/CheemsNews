import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/SettingController.dart';
import 'package:get/get.dart';

final _settingController = Get.find<SettingController>();

class ColorDot extends StatefulWidget {
  final int id;
  const ColorDot({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  _ColorDotState createState() => _ColorDotState();
}

class _ColorDotState extends State<ColorDot> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _settingController.kPrimaryColor.value =
            Color(_settingController.kColor[widget.id]);
        _settingController.idColor.value = widget.id;
        //Get.offNamed("/mainView");
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 2),
        padding: EdgeInsets.all(2),
        height: 24,
        width: 24,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            // ignore: unrelated_type_equality_checks
            color: widget.id == _settingController.idColor
                ? Color(_settingController.kColor[widget.id])
                : Colors.white,
          ),
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
              color: Color(_settingController.kColor[widget.id]),
              shape: BoxShape.circle),
        ),
      ),
    );
  }
}
