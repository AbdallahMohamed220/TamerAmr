import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tamer_amr/providers/users_provider.dart';
import 'package:tamer_amr/screens/about_us/about_us.dart';
import 'package:tamer_amr/screens/app_idea/app_idea.dart';
import 'package:tamer_amr/screens/contact_us/contact_us.dart';
import 'package:tamer_amr/screens/login/login.dart';
import 'package:tamer_amr/screens/more/component/card_items.dart';
import 'package:tamer_amr/screens/edit_profile/edit_profile.dart';
import 'package:tamer_amr/screens/checked_user_login/check_user_login.dart';
import 'package:tamer_amr/widgets/appbar.dart';
import 'package:tamer_amr/widgets/bottom_navigation_widget.dart';
import 'package:tamer_amr/widgets/floating_action_button_widget.dart';

// ignore: must_be_immutable
class MoreScreen extends StatelessWidget {
  static const routeName = 'more_screen';

  @override
  Widget build(BuildContext context) {
    final _deviceWidth = MediaQuery.of(context).size.width;
    final _deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(55.0),
        child: AppBarWidget(),
      ),
      body: Container(
        child: ListView(
          itemExtent: MediaQuery.of(context).size.height * 0.9,
          children: [
            Stack(
              children: [
                Positioned(
                  top: deviceWidth * 0.22,
                  left: deviceWidth * 0.05,
                  child: Container(
                    width: _deviceWidth * 0.9,
                    height: _deviceHeight * 0.7,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: deviceWidth * 0.15),
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Text(
                              'تأمر امر',
                              style: GoogleFonts.cairo(
                                fontSize: 23,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).primaryColor,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          CardItems(
                            text: 'تعديل الحساب',
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(EditProfileScreen.routeName);
                            },
                          ),
                          CardItems(
                            text: 'فكرة التطبيق',
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(AppIdeaScreen.routeName);
                            },
                          ),
                          CardItems(
                            text: 'من نحن',
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(AboutUsScreen.routeName);
                            },
                          ),
                          CardItems(
                            text: 'تواصل معنا',
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(ContactUsScreen.routeName);
                            },
                          ),
                          CardItems(
                            text: 'تسجيل الخروج',
                            onTap: () async {
                              await Provider.of<Users>(context, listen: false)
                                  .logout();
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()),
                                  (Route<dynamic> route) => false);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: _deviceWidth * 0.01,
                  left: _deviceWidth * 0.35,
                  child: Container(
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: 150,
                      height: 150,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButtonWidget(
        floatActionColor: Color(0xff86BED5),
      ),
      bottomNavigationBar: BottomNavigationWidget(
        selectedTab: 0,
        floatActionColor: Color(0xff86BED5),
        iconSelectedColor: Colors.blue,
      ),
    );
  }
}
