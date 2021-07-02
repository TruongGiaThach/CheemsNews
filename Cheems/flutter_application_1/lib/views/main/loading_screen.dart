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
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    
                    child: Image.asset(
                  "assets/images/CheemsNews.png",
                  fit: BoxFit.fitWidth,
                  height: 200,
                )),
              ),
            ),
            Image.asset(
              "assets/images/ponl.gif",
            ),
            FittedBox(fit: BoxFit.contain, child: CircularProgressIndicator()),
            SizedBox(height: 20,),
            FittedBox(fit: BoxFit.contain, child: Text("Initilizing...",style: TextStyle(fontSize: 18),)),
          ],
        ),
      ),
    );
  }
}
