import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tamer_amr/screens/messages/messages.dart';
import 'package:tamer_amr/screens/notification/notification.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0)),
      child: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xff2190c2),
        centerTitle: true,
        elevation: 0,
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 8),
            height: 50.0,
            width: MediaQuery.of(context).size.width / 2 - 50.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .pushReplacementNamed(MessagesScreen.routeName);
                  },
                  child: Badge(
                    badgeContent: Text(
                      '3',
                      style: GoogleFonts.cairo(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    position: BadgePosition.topStart(
                      top: -6,
                    ),
                    child: Icon(
                      Icons.mail_outline,
                      color: Colors.white,
                      size: 35,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .pushReplacementNamed(NotificationScreen.routeName);
                  },
                  child: Badge(
                    badgeContent: Text(
                      '3',
                      style: GoogleFonts.cairo(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    position: BadgePosition.topStart(
                      top: -4,
                    ),
                    child: Icon(
                      Icons.notifications,
                      color: Colors.white,
                      size: 35,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
