import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants.dart';

class PersonAvatar extends StatelessWidget {
  const PersonAvatar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Positioned(
          child: Container(
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: kPrimaryColor),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(1000),
              child: Image.asset(
                "assets/images/avatar.png",
                width: size.width * .4,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            width: 30,
            height: 30,
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.photo,
              ),
            ),
          ),
        )
      ],
    );
  }
}
