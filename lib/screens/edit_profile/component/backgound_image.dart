import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tamer_amr/screens/checked_user_login/check_user_login.dart';

// ignore: must_be_immutable
class BackgroundImage extends StatelessWidget {
  String userPhoto;
  File userImage;
  BackgroundImage({
    this.userImage,
    this.userPhoto,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: deviceWidth,
      height: deviceWidth * 0.65,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        ),
        image: DecorationImage(
          fit: (userPhoto == null ||
                  userPhoto == 'https://tomeramer.tameramr.com/assets')
              ? BoxFit.fill
              : BoxFit.cover,
          image: (userPhoto == null ||
                  userPhoto == 'https://tomeramer.tameramr.com/assets')
              ? AssetImage('assets/images/user_two.png')
              : NetworkImage(
                  userPhoto,
                ),
        ),
      ),
      child: FadeInImage.assetNetwork(
        fit: (userPhoto == null ||
                userPhoto == 'https://tomeramer.tameramr.com/assets')
            ? BoxFit.fill
            : BoxFit.cover,
        placeholder: 'assets/images/user_two.png',
        image: userPhoto == 'https://tomeramer.tameramr.com/assets'
            ? 'assets/images/user_two.png'
            : userPhoto,
      ),
    );
  }
}
