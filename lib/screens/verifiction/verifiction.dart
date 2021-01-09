import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;
import 'package:tamer_amr/screens/verifiction/component/pin_code_item.dart';
import 'package:tamer_amr/screens/checked_user_login/check_user_login.dart';

class DecimalTextInputFormatter extends TextInputFormatter {
  DecimalTextInputFormatter({this.decimalRange})
      : assert(decimalRange == null || decimalRange > 0);

  final int decimalRange;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue, // unused.
    TextEditingValue newValue,
  ) {
    TextSelection newSelection = newValue.selection;
    String truncated = newValue.text;

    if (decimalRange != null) {
      String value = newValue.text;

      if (value.contains(".") &&
          value.substring(value.indexOf(".") + 1).length > decimalRange) {
        truncated = oldValue.text;
        newSelection = oldValue.selection;
      } else if (value == ".") {
        truncated = "0.";

        newSelection = newValue.selection.copyWith(
          baseOffset: math.min(truncated.length, truncated.length + 1),
          extentOffset: math.min(truncated.length, truncated.length + 1),
        );
      }

      return TextEditingValue(
        text: truncated,
        selection: newSelection,
        composing: TextRange.empty,
      );
    }
    return newValue;
  }
}

class VerificationScreen extends StatelessWidget {
  static const routeName = 'verification_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
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
                top: -15,
                right: 80,
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
              Positioned(
                top: deviceWidth * 0.15,
                left: deviceWidth * 0.35,
                child: SizedBox(
                  width: 150,
                  height: 150,
                  child: Image.asset(
                    'assets/images/logo.png',
                  ),
                ),
              ),
              Positioned(
                top: deviceWidth * 0.5,
                left: deviceWidth * 0.42,
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
                top: deviceWidth * 0.66,
                left: deviceWidth * 0.28,
                child: Text(
                  "تأكيد رقم الهاتف",
                  style: GoogleFonts.cairo(
                    fontSize: 35,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).accentColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Positioned(
                top: deviceWidth * 0.83,
                left: deviceWidth * 0.1,
                child: Container(
                  width: deviceWidth * .8,
                  height: deviceWidth * 1.5,
                  decoration: BoxDecoration(
                    color: Color(0xffA6D6DC),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: deviceWidth * 0.85,
                left: deviceWidth * 0.38,
                child: Text(
                  "كود التأكيد",
                  style: GoogleFonts.cairo(
                    fontSize: 30,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff218CD2),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Positioned(
                top: deviceWidth * 1,
                left: deviceWidth * 0.25,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    PinCodeItem(),
                    SizedBox(
                      width: 12,
                    ),
                    PinCodeItem(),
                    SizedBox(
                      width: 12,
                    ),
                    PinCodeItem(),
                    SizedBox(
                      width: 12,
                    ),
                    PinCodeItem(),
                  ],
                ),
              ),
              Positioned(
                top: deviceWidth * 1.2,
                left: deviceWidth * 0.3,
                child: Text(
                  "إعادة ارسال كود التفعيل",
                  style: GoogleFonts.cairo(
                    fontSize: 25,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff218CD2),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Positioned(
                bottom: 0,
                left: deviceWidth * 0.23,
                child: Container(
                  width: 250,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Color(0xff218CD2),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Text(
                      "تأكيد",
                      style: GoogleFonts.cairo(
                        fontSize: 35,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).accentColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
