import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tamer_amr/screens/checked_user_login/check_user_login.dart';
import 'package:tamer_amr/screens/intro/intro.dart';

class SplashScreen extends StatelessWidget {
  static const routeName = 'splash_screen';
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
              top: deviceWidth * 0.25,
              left: deviceWidth * 0.3,
              child: SizedBox(
                width: 200,
                height: 250,
                child: Image.asset(
                  'assets/images/logo.png',
                ),
              ),
            ),
            Positioned(
              top: deviceWidth * 0.8,
              left: deviceWidth * 0.4,
              child: Text(
                "تآمر أمر",
                style: GoogleFonts.cairo(
                  fontSize: 35,
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).accentColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Positioned(
              bottom: 0,
              left: deviceWidth * 0.3,
              child: InkWell(
                onTap: () {
                  Navigator.of(context)
                      .pushReplacementNamed(IntroScreen.routeName);
                },
                child: Container(
                  width: 200,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Text(
                    "دخول",
                    style: GoogleFonts.cairo(
                      fontSize: 33,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff41A6BB),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
