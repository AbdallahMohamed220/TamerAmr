import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tamer_amr/screens/checked_user_login/check_user_login.dart';
import 'package:tamer_amr/screens/view_image/view_image.dart';

// ignore: must_be_immutable
class AccountIdentityImage extends StatelessWidget {
  String imageUrl;
  AccountIdentityImage({this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: deviceWidth * 0.49,
      left: deviceWidth * 0.12,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => ViewImageScreen(
                    imageUrl: imageUrl,
                  ),
                ),
              );
            },
            child: Container(
              width: 100,
              height: 37,
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
              ),
              child: Text(
                'إستعراض ',
                style: GoogleFonts.cairo(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).primaryColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(width: deviceWidth * 0.33),
          Text(
            'صورة الهوية',
            style: GoogleFonts.cairo(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).primaryColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
