import 'package:flutter/material.dart';
import 'package:tamer_amr/screens/checked_user_login/check_user_login.dart';

class AccountCardItem extends StatelessWidget {
  const AccountCardItem({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: deviceWidth * 0.1,
      left: deviceWidth * 0.05,
      child: Container(
        width: deviceWidth * 0.9,
        height: deviceHeight * 0.8,
        child: Card(
          elevation: 7,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
      ),
    );
  }
}
