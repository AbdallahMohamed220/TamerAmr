import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tamer_amr/providers/users_provider.dart';
import 'package:tamer_amr/screens/checked_user_login/check_user_login.dart';

class AccountUserName extends StatelessWidget {
  const AccountUserName({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String username = Provider.of<Users>(context, listen: false).name;
    return Positioned(
      top: deviceWidth * 0.4,
      left: deviceWidth * 0.18,
      child: Container(
        width: 300,
        height: 300,
        child: Text(
          username ?? '',
          style: GoogleFonts.cairo(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).primaryColor,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
