import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                  //color: Colors.yellowAccent,
                  child: Image.asset(
                "assets/images/CheemsNews.png",
                fit: BoxFit.fitWidth,
                height: 200,
              )),
            ),
            Image.asset(
              "assets/images/ponl.gif",
              height: 200,
            ),
            FittedBox(fit: BoxFit.contain, child: CircularProgressIndicator()),
            FittedBox(fit: BoxFit.contain, child: Text("Initilizing...")),
          ],
        ),
      ),
    );
  }
}
