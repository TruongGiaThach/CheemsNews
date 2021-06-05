import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class FullImageScreen extends StatelessWidget {
  final String imageURL;
  final String name;
  FullImageScreen({@required this.imageURL, @required this.name});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: Text("$name"),
              backgroundColor: Colors.transparent,
            ),
            body: SafeArea(
              child: PhotoView(
                imageProvider: CachedNetworkImageProvider(imageURL),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
