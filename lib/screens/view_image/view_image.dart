import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

// ignore: must_be_immutable
class ViewImageScreen extends StatelessWidget {
  String imageUrl;
  ViewImageScreen({this.imageUrl});
  @override
  Widget build(BuildContext context) {
    return Container(
        child: PhotoView(
      imageProvider: NetworkImage(imageUrl),
    ));
  }
}
