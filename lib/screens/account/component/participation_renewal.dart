import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tamer_amr/screens/checked_user_login/check_user_login.dart';

class AccountParticipationRenewal extends StatelessWidget {
  const AccountParticipationRenewal({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: deviceWidth * 1.1,
      left: deviceWidth * 0.34,
      child: Container(
        width: deviceWidth * 0.33,
        height: 55,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
        child: Text(
          'تجديد الاشتراك',
          style: GoogleFonts.cairo(
            fontSize: 25,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).primaryColor,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
