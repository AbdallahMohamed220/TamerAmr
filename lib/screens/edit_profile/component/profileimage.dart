import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tamer_amr/screens/checked_user_login/check_user_login.dart';

// ignore: must_be_immutable
class ProfileImageWidget extends StatelessWidget {
  String userPhoto;
  File userImage;
  ProfileImageWidget({
    this.userImage,
    this.userPhoto,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: deviceWidth * 0.35,
      left: deviceWidth * 0.28,
      child: Container(
        width: 200,
        height: 200.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: (userPhoto == null ||
                    userPhoto == 'https://tomeramer.tameramr.com/assets')
                ? AssetImage('assets/images/user_placeholder.png')
                : NetworkImage(userPhoto),
          ),
        ),
        child: FadeInImage.assetNetwork(
          placeholder: 'assets/images/user_placeholder.png',
          image: userPhoto == 'https://tomeramer.tameramr.com/assets'
              ? 'assets/images/user_placeholder.png'
              : userPhoto,
        ),
      ),
    );
  }
}
