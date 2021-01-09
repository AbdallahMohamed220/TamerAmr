import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tamer_amr/screens/checked_user_login/check_user_login.dart';
import 'package:tamer_amr/screens/terms_of_use/terms_of_use.dart';

// ignore: must_be_immutable
class IntroScreenWidget extends StatelessWidget {
  String image;
  String title;
  String content;
  String subContent;
  double imagePosition;
  IntroScreenWidget({
    this.image,
    this.title,
    this.content,
    this.subContent,
    this.imagePosition,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: deviceWidth,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xff209AA9),
            Color(0xff1EA384),
          ],
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -5,
            left: imagePosition,
            child: Opacity(
              opacity: 0.1,
              child: Image.asset(
                'assets/images/vesba-vevtor.png',
                width: deviceWidth + 300,
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
          Container(
            padding: EdgeInsets.only(top: 100, left: 50, right: 50, bottom: 60),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Image.asset(image),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  title,
                  style: GoogleFonts.cairo(
                    fontSize: 45,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).accentColor,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  content,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.cairo(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).accentColor,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  subContent,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.cairo(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).accentColor,
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                InkWell(
                  onTap: () {},
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .pushReplacementNamed(TermsOfUseScreen.routeName);
                    },
                    child: Container(
                      width: 80,
                      height: 42,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 3),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        "تخطي",
                        style: GoogleFonts.cairo(
                          fontSize: 23,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).accentColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
