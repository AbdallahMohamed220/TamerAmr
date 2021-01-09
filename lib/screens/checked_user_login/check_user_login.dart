import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tamer_amr/screens/check_user_type/check_user_type.dart';
import 'package:tamer_amr/screens/splash/splash.dart';

var deviceWidth;
var deviceHeight;

class CheckUserLogin extends StatefulWidget {
  static const routeName = 'check_user_login_screen';
  @override
  _CheckUserLoginState createState() => _CheckUserLoginState();
}

class _CheckUserLoginState extends State<CheckUserLogin> {
  @override
  void initState() {
    super.initState();
    checkUserLogin();
  }

  void checkUserLogin() async {
    SharedPreferences logindata = await SharedPreferences.getInstance();
    String userToken = logindata.getString('userToken');

    if (userToken == null) {
      Navigator.pushReplacement(
          context, new MaterialPageRoute(builder: (context) => SplashScreen()));
    } else {
      Navigator.pushReplacement(context,
          new MaterialPageRoute(builder: (context) => CheckUserTypeScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;
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
