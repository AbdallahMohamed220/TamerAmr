import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AccountDateOfExpire extends StatelessWidget {
  const AccountDateOfExpire({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _deviceWidth = MediaQuery.of(context).size.width;
    return Positioned(
      top: _deviceWidth * 0.97,
      left: _deviceWidth * 0.06 - 1,
      child: Container(
        width: _deviceWidth * 0.89 - 2,
        height: 60,
        decoration: BoxDecoration(
          color: Color(0xff99CDE2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              margin: EdgeInsets.only(right: 30),
              width: 25,
              height: 25,
              child: Image.asset('assets/icons/time-left.png'),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 30.0),
              child: Text(
                'متبقى على إنتهاء الإشتراك 6 أشهر',
                style: GoogleFonts.cairo(
                  fontSize: 27,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).primaryColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
