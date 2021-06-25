import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/Comment.dart';
import 'package:flutter_application_1/views/widgets.dart';

class CommentCard extends StatelessWidget {
  CommentCard({Key? key, required this.cmt}) : super(key: key);
  final Comments cmt;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(4),
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.asset('assets/images/guestImage.jpg'),
              ),
            ),
            Text(
              cmt.userName,
              style: minimzeTextStyle(),
            ),
            Text(
              cmt.time.toString(),
              style: minimzeTextStyle(),
            )
          ],
        ),
        Container(
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          child: Text(
            cmt.body,
            style: newsBodyTextStyle(),
          ),
        )
      ],
    );
  }
}
