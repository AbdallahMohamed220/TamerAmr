import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AccountBalance extends StatelessWidget {
  const AccountBalance({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(right: 8),
          width: 25,
          height: 25,
          child: Image.asset('assets/icons/coin.png'),
        ),
        Text(
          '2200 rs ',
          style: GoogleFonts.cairo(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).primaryColor,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
