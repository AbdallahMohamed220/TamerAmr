import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tamer_amr/widgets/appbar.dart';
import 'package:tamer_amr/widgets/bottom_navigation_widget.dart';
import 'package:tamer_amr/widgets/floating_action_button_widget.dart';

class MessagesScreen extends StatelessWidget {
  static const routeName = 'messages_screen';

  const MessagesScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(55.0),
        child: AppBarWidget(),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Column(
                    children: [
                      Container(
                        width: _deviceWidth * 0.5,
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.lightBlue,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                          ),
                        ),
                      ),
                      Container(
                          padding: const EdgeInsets.only(left: 8.0),
                          width: _deviceWidth * 0.5,
                          height: 30,
                          alignment: Alignment.center,
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              height: 30,
                              width: 90,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image(
                                    image: AssetImage('assets/icons/clock.png'),
                                    width: 20,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    'منذ دقيقة',
                                    style: GoogleFonts.cairo(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context)
                                          .primaryColor
                                          .withOpacity(0.5),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Column(
                      children: [
                        Container(
                          width: _deviceWidth * 0.5,
                          height: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                              topLeft: Radius.circular(15),
                            ),
                          ),
                          // child: Text(
                          //   'الطلبات الحالية',
                          //   style: GoogleFonts.cairo(
                          //     fontSize: 23,
                          //     fontWeight: FontWeight.w600,
                          //     color: Theme.of(context).accentColor,
                          //   ),
                          //   textAlign: TextAlign.center,
                          // ),
                        ),
                        Container(
                            padding: const EdgeInsets.only(left: 8.0),
                            width: _deviceWidth * 0.5,
                            height: 30,
                            alignment: Alignment.center,
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                height: 30,
                                width: 90,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image(
                                      image:
                                          AssetImage('assets/icons/clock.png'),
                                      width: 20,
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      'منذ دقيقة',
                                      style: GoogleFonts.cairo(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context)
                                            .primaryColor
                                            .withOpacity(0.5),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButtonWidget(
        floatActionColor: Color(0xff86BED5),
      ),
      bottomNavigationBar: BottomNavigationWidget(
        floatActionColor: Color(0xff86BED5),
        iconSelectedColor: Colors.blue,
      ),
    );
  }
}
