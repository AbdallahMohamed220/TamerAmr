import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class CardItems extends StatelessWidget {
  String text;
  Function onTap;
  CardItems({this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    final _deviceWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.all(5),
      child: InkWell(
        onTap: onTap,
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          color: Colors.grey[200],
          child: ClipPath(
            child: Container(
              height: 50,
              width: _deviceWidth * 0.9,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(color: Colors.blue, width: 10),
                ),
              ),
              child: Text(
                text,
                style: GoogleFonts.cairo(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).primaryColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            clipper: ShapeBorderClipper(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
