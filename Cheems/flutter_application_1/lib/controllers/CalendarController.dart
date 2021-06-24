import 'package:flutter_application_1/utils/lunar_solar_utils.dart';
import 'package:flutter_application_1/utils/utilsCalendar.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class calendarController extends GetxController {
  XuLiEvent a = Get.find<XuLiEvent>();
  DateTime? selectedDay;
  RxList<String> selectedEvents = RxList();
  Rx<DateTime> focusedDay = DateTime.now().obs;
  DateTime? rangeStart;
  DateTime? rangeEnd;
  Rx<CalendarFormat> calendarFormat = CalendarFormat.month.obs;
  RangeSelectionMode rangeSelectionMode = RangeSelectionMode.toggledOff;
  Rx<DateTime> selectedlunar = DateTime.now().obs;

  @override
  void onInit() {
    super.onInit();
    selectedEvents.value = a.ReturnEvent(DateTime.now());
  }

  List<String> getEventsForDay(DateTime day) {
    return a.ReturnEvent(day);
  }

  List<String> getEventsForRange(DateTime start, DateTime end) {
    // Implementation example
    final days = a.daysInRange(start, end);

    return [
      for (final d in days) ...getEventsForDay(d),
    ];
  }

  void onDaySelected(DateTime selectedday, DateTime focusedday) {
    if (!isSameDay(selectedDay, selectedday)) {
      selectedDay = selectedday;
      focusedDay.value = focusedday;
      rangeStart = null; // Important to clean those
      rangeEnd = null;
      rangeSelectionMode = RangeSelectionMode.toggledOff;

      var listlunar = convertSolar2Lunar(
          selectedday.day, selectedday.month, selectedday.year, 7);
      selectedlunar.value =
          new DateTime(listlunar[2], listlunar[1], listlunar[0]);
      selectedEvents.value = getEventsForDay(selectedday);
    }
  }

  void onRangeSelected(DateTime? start, DateTime? end, DateTime focusedday) {
    selectedDay = null;
    focusedDay.value = focusedday;
    rangeStart = start;
    rangeEnd = end;
    rangeSelectionMode = RangeSelectionMode.toggledOn;

    // `start` or `end` could be null
    if (start != null && end != null) {
      selectedEvents.value = getEventsForRange(start, end);
    } else if (start != null) {
      selectedEvents.value = getEventsForDay(start);
    } else if (end != null) {
      selectedEvents.value = getEventsForDay(end);
    }
  }
}
