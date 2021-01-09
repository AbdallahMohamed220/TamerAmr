import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tamer_amr/providers/users_provider.dart';
import 'package:tamer_amr/screens/checked_user_login/check_user_login.dart';
import 'package:tamer_amr/screens/home/home.dart';
import 'package:tamer_amr/screens/home_partnership/home_partnership.dart';

class CheckUserTypeScreen extends StatefulWidget {
  static const routeName = 'check_user_type_screen';

  @override
  _CheckUserTypeScreenState createState() => _CheckUserTypeScreenState();
}

class _CheckUserTypeScreenState extends State<CheckUserTypeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tansactionHomePage();
  }

  tansactionHomePage() {
    Timer(Duration(seconds: 0), () {
      String userType = Provider.of<Users>(context, listen: false).userType;

      if (userType == 'مستخدم') {
        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      } else {
        Navigator.of(context)
            .pushReplacementNamed(HomePartnerShipScreen.routeName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: deviceHeight,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xff2190C6),
              Color(0xff209AA4),
            ],
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: -5,
              left: -10,
              child: Opacity(
                opacity: 0.1,
                child: Image.asset(
                  'assets/images/vesba-vevtor.png',
                  width: deviceWidth * 1.5,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Opacity(
                opacity: 0.8,
                child: Image.asset(
                  'assets/images/saudi-arabia-building.png',
                  width: deviceWidth,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: deviceWidth * 0.8,
              left: deviceWidth * 0.4,
              child: Text(
                "جارى التحميل",
                style: GoogleFonts.cairo(
                  fontSize: 35,
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).accentColor,
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
