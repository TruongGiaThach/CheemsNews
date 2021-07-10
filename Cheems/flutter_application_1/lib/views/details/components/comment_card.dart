import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/SettingController.dart';
import 'package:flutter_application_1/models/Comment.dart';
import 'package:flutter_application_1/views/widgets.dart';
import 'package:intl/intl.dart';

class CommentCard extends StatelessWidget {
  CommentCard({Key? key, required this.cmt}) : super(key: key);
  final Comments cmt;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(4),
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.network(cmt.userImage),
                  ),
                ),
                Text(
                  cmt.userName,
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: SettingController().textSize.value),
                ),
                Spacer(),
                Text(
                  DateFormat('yyyy-MM-dd – kk:mm').format(cmt.time),
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: SettingController().textSize.value),
                ),
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.black38)),
              child: Text(
                cmt.body,
                style:
                    TextStyle(color: Colors.black87, fontSize: 18, height: 1.5),
              ),
            )
          ],
        ),
      ),
    );
  }
}
