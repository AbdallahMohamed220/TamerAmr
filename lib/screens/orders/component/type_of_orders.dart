import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tamer_amr/screens/checked_user_login/check_user_login.dart';

// ignore: must_be_immutable
class TypeOfOrdersScreen extends StatelessWidget {
  String typeOfOrder;
  bool completed;
  Function onTap;
  TypeOfOrdersScreen({this.typeOfOrder, this.completed, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: deviceWidth * 0.45,
        height: 55,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: completed
              ? BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                )
              : BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
        ),
        child: Text(
          typeOfOrder,
          style: GoogleFonts.cairo(
            fontSize: 23,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).accentColor,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
