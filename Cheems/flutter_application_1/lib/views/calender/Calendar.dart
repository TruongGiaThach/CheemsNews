import 'package:flutter_application_1/controllers/SettingController.dart';
import 'package:flutter_application_1/services/DataService.dart';
import 'package:flutter_application_1/controllers/CalendarController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatelessWidget {
  Calendar({
    Key? key,
  }) : super(key: key);
  final controller = Get.find<calendarController>();
  final eventcontroller = Get.find<DataService>();
  final _settingController = Get.find<SettingController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _settingController.kPrimaryColor.value,
      ),
      body: Column(
        children: [
          Obx(
            () => TableCalendar<String>(
              firstDay: DateTime.parse('2001-03-03'),
              lastDay: DateTime.parse('2040-10-11'),
              focusedDay: controller.focusedDay.value,
              selectedDayPredicate: (day) =>
                  isSameDay(controller.selectedDay, day),
              rangeStartDay: controller.rangeStart,
              rangeEndDay: controller.rangeEnd,
              calendarFormat: controller.calendarFormat.value,
              rangeSelectionMode: controller.rangeSelectionMode,
              eventLoader: controller.getEventsForDay,
              startingDayOfWeek: StartingDayOfWeek.monday,
              calendarStyle: CalendarStyle(
                // Use `CalendarStyle` to customize the UI
                outsideDaysVisible: false,
              ),
              onDaySelected: controller.onDaySelected,
              onRangeSelected: controller.onRangeSelected,
              onFormatChanged: (format) {
                if (controller.calendarFormat != format) {
                  controller.calendarFormat.value = format;
                }
              },
              onPageChanged: (focusedday) {
                controller.focusedDay.value = focusedday;
              },
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(
            'Âm lịch',
            style: TextStyle(
              fontSize: 20,
              color: Colors.blue,
              fontFamily: "Caveat",
              fontWeight: FontWeight.w700,
            ),
          ),
          Obx(
            () => Text(
              controller.selectedlunar.value.day.toString() +
                  "/" +
                  controller.selectedlunar.value.month.toString(),
              style: TextStyle(
                fontSize: 20,
                color: Colors.blue,
                fontFamily: "Caveat",
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Obx(
            () => Expanded(
              child: ListView.builder(
                itemCount: controller.selectedEvents.value.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 4.0,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.blue,
                      ),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: ListTile(
                      onTap: () =>
                          print('${controller.selectedEvents.value[index]}'),
                      title: Text(
                        '${controller.selectedEvents.value[index]}',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.blue,
                          fontFamily: "Caveat",
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
