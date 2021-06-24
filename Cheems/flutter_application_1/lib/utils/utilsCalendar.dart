import 'package:flutter_application_1/services/DataService.dart';
import 'package:flutter_application_1/utils/lunar_solar_utils.dart';
import 'package:get/get.dart';

/// Example event class.
class XuLiEvent {
  final data = Get.find<DataService>();

  ReturnEvent(DateTime check) {
    List<String> eventcontrol = [];
    data.dataresult.value.forEach((element) {
      if (check.month == element.date.month && check.day == element.date.day) {
        eventcontrol.add(element.event);
      }
    });
    data.dataresult2.value.forEach((element) {
      var listdays = convertSolar2Lunar(check.day, check.month, check.year, 7);
      if (listdays[0].toString() == element.date.day.toString() &&
          listdays[1].toString() == element.date.month.toString()) {
        eventcontrol.add(element.event);
      }
    });
    return eventcontrol;
  }

  List<DateTime> daysInRange(DateTime first, DateTime last) {
    final dayCount = last.difference(first).inDays + 1;
    return List.generate(
      dayCount,
      (index) => DateTime.utc(first.year, first.month, first.day + index),
    );
  }
}
