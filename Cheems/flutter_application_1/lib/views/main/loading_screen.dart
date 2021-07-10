import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 5,
              child: Container(
                  child: Image.asset(
                "assets/images/CheemsNews.png",
                fit: BoxFit.fitWidth,
              )),
            ),
            Expanded(
              flex: 10,
              child: Image.asset(
                "assets/images/ponl.gif",
              ),
            ),
            Expanded(
              flex: 1,
              child: FittedBox(
                  fit: BoxFit.contain, child: CircularProgressIndicator()),
            ),
            Expanded(
              flex: 3,
              child: Center(
                child: Text(
                  "Initilizing...",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
