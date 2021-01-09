import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AccountCreateNewBouquet extends StatelessWidget {
  const AccountCreateNewBouquet({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _deviceWidth = MediaQuery.of(context).size.width;
    return Container(
      width: _deviceWidth * 0.3,
      height: 66,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
      ),
      child: Text(
        'إنشاء باقة جديدة',
        style: GoogleFonts.cairo(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Theme.of(context).primaryColor,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
