import 'package:flutter/material.dart';
import 'package:tamer_amr/screens/checked_user_login/check_user_login.dart';

// ignore: must_be_immutable
class TitleWidget extends StatelessWidget {
  String usrname;
  TitleWidget({this.usrname});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: deviceWidth * 0.82,
      left: deviceWidth * 0.3,
      child: Container(
        width: deviceWidth * 0.42,
        height: deviceWidth * 0.12,
        alignment: Alignment.topCenter,
        child: Text(
          usrname ?? "usrname",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
