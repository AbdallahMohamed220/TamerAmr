import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tamer_amr/widgets/appbar.dart';
import 'package:tamer_amr/screens/edit_profile/component/backgound_image.dart';
import 'package:tamer_amr/screens/edit_profile/component/profileimage.dart';
import 'package:tamer_amr/widgets/separator.dart';
import 'package:tamer_amr/screens/edit_profile/component/textform.dart';
import 'package:tamer_amr/screens/edit_profile/component/title.dart';
import 'package:tamer_amr/widgets/bottom_navigation_widget.dart';
import 'package:tamer_amr/widgets/floating_action_button_widget.dart';

enum SingingCharacter { lafayette, jefferson }

class ProfileScreen extends StatefulWidget {
  static const routeName = 'profile_screen';

  ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int selectedRadio;

  @override
  void initState() {
    super.initState();
    selectedRadio = 0;
  }

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _deviceWidth = MediaQuery.of(context).size.width;
    final _deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: _deviceWidth,
        height: _deviceHeight,
        child: Stack(
          children: [
            Container(
              width: _deviceWidth,
              height: _deviceHeight,
              child: ListView(
                children: [
                  Container(
                    width: _deviceWidth,
                    height: _deviceWidth * 0.85,
                    child: Stack(
                      children: [
                        BackgroundImage(),
                        TitleWidget(),
                        ProfileImageWidget(),
                        Positioned(
                          top: _deviceWidth * 0.7,
                          left: _deviceWidth * 0.47,
                          child: InkWell(
                            child: Container(
                              width: 35,
                              height: 35,
                              child: Image.asset('assets/icons/edit.png'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        TextFormWidget(
                          hintText: "الاسم بالكامل",
                        ),
                        SizedBox(height: 5),
                        TextFormWidget(hintText: "اسم المستخدم"),
                        SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8, right: 25.0, left: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.all(8),
                                width: 200,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey[400],
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                  color: Color(0xffF4F4F4),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(
                                      Icons.cloud_upload,
                                      color: Colors.grey[400],
                                    ),
                                    Text(
                                      'إرفاق صورة ',
                                      style: GoogleFonts.cairo(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400,
                                        color: Theme.of(context)
                                            .primaryColor
                                            .withOpacity(0.5),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                'إرفاق صورة الهوية',
                                style: GoogleFonts.cairo(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.5),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 15, right: 25.0, left: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  padding: EdgeInsets.all(8),
                                  width: 200,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey[400],
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(15),
                                    color: Color(0xffF4F4F4),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(
                                        Icons.cloud_upload,
                                        color: Colors.grey[400],
                                      ),
                                      Text(
                                        'إرفاق صورة ',
                                        style: GoogleFonts.cairo(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400,
                                          color: Theme.of(context)
                                              .primaryColor
                                              .withOpacity(0.5),
                                        ),
                                      ),
                                    ],
                                  )),
                              Text(
                                'إرفاق صورة رخصة القيادة',
                                style: GoogleFonts.cairo(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.5),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 15.0),
                          child: const MySeparator(
                            color: Color(0xffF8E6D1),
                          ),
                        ),
                        Stack(
                          children: [
                            Padding(
                                padding: const EdgeInsets.only(top: 50.0),
                                child: TextFormWidget(
                                    hintText: "كلمة المرور القديمة")),
                            Center(
                              child: Container(
                                width: 200,
                                height: 50,
                                alignment: Alignment.center,
                                child: Text(
                                  'تعديل كلمة المرور',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                decoration: BoxDecoration(
                                  color: Color(0xff2190C2),
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(40.0),
                                    topLeft: Radius.circular(40.0),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        TextFormWidget(hintText: "كلمة المرور الجديدة"),
                        SizedBox(height: 10),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Container(
                              width: 180,
                              height: 50,
                              alignment: Alignment.center,
                              child: Text(
                                'حفظ الاعدادات',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xff2190C2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(width: 450, height: 70, child: AppBarWidget()),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButtonWidget(
        floatActionColor: Colors.blue,
      ),
      bottomNavigationBar: BottomNavigationWidget(
        floatActionColor: Color(0xff86BED5),
        iconSelectedColor: Colors.blue,
      ),
    );
  }
}
