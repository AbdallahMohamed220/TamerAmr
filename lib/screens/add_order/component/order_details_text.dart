import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddOrderDetailsText extends StatelessWidget {
  const AddOrderDetailsText({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _deviceWidth = MediaQuery.of(context).size.width;

    return Center(
      child: Container(
        width: _deviceWidth * .32,
        height: 45,
        alignment: Alignment.center,
        child: Text(
          'تفاصيل الطلب',
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
