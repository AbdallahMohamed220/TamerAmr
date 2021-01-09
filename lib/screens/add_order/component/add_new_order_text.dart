import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tamer_amr/screens/checked_user_login/check_user_login.dart';

class AddNewOrderText extends StatelessWidget {
  const AddNewOrderText({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: deviceWidth * .35,
        height: 45,
        alignment: Alignment.center,
        child: Text(
          'إرسال طلب جديد',
          style: GoogleFonts.cairo(
            fontSize: 23,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).accentColor,
          ),
          textAlign: TextAlign.center,
        ),
        decoration: BoxDecoration(
          color: Color(0xff2190C2),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30.0),
            topLeft: Radius.circular(30.0),
          ),
        ),
      ),
    );
  }
}
