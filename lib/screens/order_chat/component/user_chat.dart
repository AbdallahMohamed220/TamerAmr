import 'package:badges/badges.dart';
import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:tamer_amr/screens/checked_user_login/check_user_login.dart';
import 'package:tamer_amr/screens/notification/notification.dart';

// ignore: must_be_immutable
class UserChatScreen extends StatefulWidget {
  int id;
  String name;
  String photo;
  int price;
  int points;
  String createdAt;
  UserChatScreen({
    this.id,
    this.name,
    this.photo,
    this.price,
    this.createdAt,
    this.points,
  });

  @override
  _UserChatScreenState createState() => _UserChatScreenState();
}

class _UserChatScreenState extends State<UserChatScreen> {
  double _containerHeight = 70;
  KeyboardVisibilityNotification _keyboardVisibility =
      new KeyboardVisibilityNotification();
  int _keyboardVisibilitySubscriberId;
  bool _keyboardState;

  @protected
  void initState() {
    super.initState();

    _keyboardState = _keyboardVisibility.isKeyboardVisible;

    _keyboardVisibilitySubscriberId = _keyboardVisibility.addNewListener(
      onChange: (bool visible) {
        setState(() {
          if (visible) {
            _containerHeight = 100;
          } else {
            _containerHeight = 70;
          }
          _keyboardState = visible;
        });
      },
    );
  }

  @override
  // ignore: must_call_super
  void dispose() {
    _keyboardVisibility.removeListener(_keyboardVisibilitySubscriberId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE1E1E1),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  width: deviceWidth,
                  height: deviceHeight,
                  child: ListView(
                    children: [
                      Column(
                        children: [
                          Container(
                            height: 145,
                            alignment: Alignment.bottomCenter,
                            decoration: BoxDecoration(
                              color: Color(0xff186A8C),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                            ),
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: Row(
                                children: [
                                  Container(
                                    width: 70.0,
                                    height: 70.0,
                                    margin: EdgeInsets.only(
                                      right: 30,
                                      top: 50,
                                    ),
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                          widget.photo,
                                        ),
                                      ),
                                      color: Colors.grey[300],
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 15, top: 50),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          widget.name,
                                          style: GoogleFonts.cairo(
                                            fontSize: 23,
                                            fontWeight: FontWeight.w600,
                                            color:
                                                Theme.of(context).accentColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    margin: const EdgeInsets.only(
                                      top: 50,
                                      left: 15,
                                    ),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            right: 10,
                                            left: 5,
                                            top: 3,
                                          ),
                                          child: Image.asset(
                                            'assets/icons/time-left.png',
                                            width: 18,
                                            height: 18,
                                            color:
                                                Theme.of(context).accentColor,
                                          ),
                                        ),
                                        Text(
                                          widget.createdAt,
                                          style: GoogleFonts.cairo(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w600,
                                            color:
                                                Theme.of(context).accentColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: deviceWidth * 0.9,
                            height: 70.0,
                            decoration: BoxDecoration(
                              color: Color(0xff303030),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  width: deviceWidth * 0.2,
                                  height: deviceWidth * 0.07,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    "موافق",
                                    style: GoogleFonts.cairo(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context).accentColor,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "هل توافق على قبول العرض المقدم ؟",
                                  style: GoogleFonts.cairo(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(context).accentColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: deviceWidth * 0.9,
                            height: 70.0,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  width: deviceWidth * 0.2,
                                  height: deviceWidth * 0.07,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    "موافق",
                                    style: GoogleFonts.cairo(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context).accentColor,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "إعادة الطلب",
                                  style: GoogleFonts.cairo(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(context).accentColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Container(
                              width: deviceWidth * 0.9,
                              height: 70.0,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    width: deviceWidth * 0.2,
                                    height: deviceWidth * 0.07,
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      "موافق",
                                      style: GoogleFonts.cairo(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context).accentColor,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    " تم التسديد",
                                    style: GoogleFonts.cairo(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context).accentColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Bubble(
                        margin: BubbleEdges.only(top: 20, left: 20),
                        alignment: Alignment.topLeft,
                        nip: BubbleNip.leftTop,
                        nipWidth: 20,
                        nipHeight: 20,
                        stick: true,
                        elevation: 0,
                        child: Container(
                          alignment: Alignment.topRight,
                          width: deviceWidth * 0.5,
                          height: deviceWidth * 0.3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "العرض المقدم لتوصيل الطلب ${widget.price} ريال\n",
                                  textAlign: TextAlign.right,
                                  style: GoogleFonts.cairo(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Image.asset(
                                  'assets/icons/check.png',
                                  width: 10,
                                  height: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 250,
                        ),
                        child: Bubble(
                          margin: BubbleEdges.only(top: 20, right: 20),
                          alignment: Alignment.topRight,
                          nip: BubbleNip.rightTop,
                          radius: Radius.circular(10.0),
                          // nipWidth: 20,
                          // nipHeight: 20,
                          // nipRadius: 5.0,
                          elevation: 0,
                          color: Colors.blue,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Text(
                                  "هذا الكلام مثال للنص",
                                  textAlign: TextAlign.right,
                                  style: GoogleFonts.cairo(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Icon(
                                  Icons.done_all,
                                  size: 18,
                                  color: Theme.of(context).accentColor,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: deviceWidth * 2.0,
                  height: 75,
                  child: ClipRRect(
                    clipBehavior: Clip.antiAlias,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0)),
                    child: AppBar(
                      backgroundColor: Color(0xff2190c2),
                      centerTitle: true,
                      elevation: 0,
                      title: Text(
                        "المحادثات",
                        style: GoogleFonts.cairo(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                      leading: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Icon(Icons.arrow_back_ios),
                      ),
                      actions: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 8),
                          height: 50.0,
                          width: deviceWidth * 0.3,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(width: 45),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).pushReplacementNamed(
                                      NotificationScreen.routeName);
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
                                  position: BadgePosition.topStart(start: -2),
                                  child: Icon(
                                    Icons.notifications,
                                    color: Colors.white,
                                    size: 35,
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.grey[50],
            height: _containerHeight,
            child: Container(
              color: Colors.grey[50],
              margin: EdgeInsets.only(
                bottom: 10,
              ),
              child: Row(
                children: <Widget>[
                  InkWell(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Image.asset(
                        'assets/icons/send.png',
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 280,
                    margin: EdgeInsets.only(
                      left: 15,
                    ),
                    child: TextField(
                      onTap: () {},
                      textDirection: TextDirection.rtl,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.only(
                            left: 15, bottom: 11, top: 11, right: 15),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey[400], width: 0.5),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        border: InputBorder.none,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[400]),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                  ),
                  InkWell(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Image.asset(
                        'assets/icons/camera.png',
                        width: 65,
                        height: 65,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  InkWell(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 5.0, right: 8),
                      child: Image.asset(
                        'assets/icons/location.png',
                        width: 20,
                        height: 25,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
