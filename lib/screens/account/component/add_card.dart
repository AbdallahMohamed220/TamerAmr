import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tamer_amr/screens/checked_user_login/check_user_login.dart';

class AccountAddCard extends StatelessWidget {
  const AccountAddCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: deviceWidth * 1.3,
      left: deviceWidth * 0.26,
      child: Container(
        width: deviceWidth * 0.48,
        height: 55,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Color(0xffA575D9),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(right: 8, left: 8),
              width: 40,
              height: 40,
              child: Image.asset('assets/icons/visa.png'),
            ),
            Container(
              margin: EdgeInsets.only(right: 8),
              width: 40,
              height: 40,
              child: Image.asset('assets/icons/mastercard.png'),
            ),
            Text(
              'إضافة بطاقة',
              style: GoogleFonts.cairo(
                fontSize: 23,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).primaryColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
