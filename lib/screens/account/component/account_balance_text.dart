import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AccountBalanceText extends StatelessWidget {
  const AccountBalanceText({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'رصيد الحساب',
      style: GoogleFonts.cairo(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: Theme.of(context).primaryColor,
      ),
      textAlign: TextAlign.center,
    );
  }
}
