import 'package:badges/badges.dart';
import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:tamer_amr/screens/checked_user_login/check_user_login.dart';
import 'package:tamer_amr/screens/messages/messages.dart';
import 'package:tamer_amr/screens/notification/notification.dart';

class DelveryChatScreen extends StatefulWidget {
  static const routeName = 'delevery_chat_screen';

  const DelveryChatScreen({Key key}) : super(key: key);

  @override
  _DelveryChatScreenState createState() => _DelveryChatScreenState();
}

class _DelveryChatScreenState extends State<DelveryChatScreen> {
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
  void dispose() {
    _keyboardVisibility.removeListener(_keyboardVisibilitySubscriberId);
  }

  bool isError = false;
  bool isButtonPressed = false;
  TextEditingController _salesController = TextEditingController();
  TextEditingController _chargeCostController = TextEditingController();
  TextEditingController _finalCostController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _initialCharageCost = '25.0';
  Future<void> showInformationDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Image.asset(
                          'assets/icons/closed.png',
                          width: 15,
                          height: 15,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Container(
                      width: 250,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'إرفاق صورة الفتورة ',
                            style: GoogleFonts.cairo(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 40),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Image.asset(
                              'assets/icons/upload_image.png',
                              width: 30,
                              height: 20,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 25),
                    BillInputs(
                      label: 'تكلفة المشتريات',
                      controller: _salesController,
                      readOnly: false,
                      onChange: (value) {
                        setState(() {
                          double _salseCost = double.parse(value);
                          double _charageCost =
                              double.parse(_initialCharageCost);
                          double _finalCost;
                          if (!value.isEmpty) {
                            _finalCost = _salseCost + _charageCost;
                          } else {
                            _finalCost = _charageCost;
                          }
                          _finalCost = _finalCost + 0.0;

                          _finalCostController.text = _finalCost.toString();
                        });
                      },
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: 250,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: 120,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 4.0, left: 5),
                                  child: Text(
                                    'ر.س',
                                    style: GoogleFonts.cairo(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 80,
                                  height: 30,
                                  child: TextFormField(
                                    textAlign: TextAlign.center,
                                    initialValue: _initialCharageCost,
                                    readOnly: true,
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'قيمة غير صحيحة';
                                      } else {
                                        return null;
                                      }
                                    },
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      contentPadding: EdgeInsets.only(left: 10),
                                      errorStyle: GoogleFonts.cairo(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                          width: 0.5,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                      ),
                                      border: InputBorder.none,
                                      focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 25),
                          Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Text(
                              'تكلفة التوصيل',
                              style: GoogleFonts.cairo(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    BillInputs(
                      label: 'المجموع الكلى     ',
                      readOnly: true,
                      controller: _finalCostController,
                      onChange: (value) {},
                    ),
                    SizedBox(height: 30),
                    InkWell(
                      onTap: () {
                        if (!_formKey.currentState.validate()) {
                          return;
                        }
                      },
                      child: Container(
                        width: 200,
                        height: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Text(
                          'إنهاء الطلب و تأكيد الفتورة',
                          style: GoogleFonts.cairo(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
        });
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
                                        image: AssetImage(
                                          'assets/images/logo.png',
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
                                          'فيصل الشرارى',
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
                                          "منذ ساعة",
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
                        ],
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
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).pushReplacementNamed(
                                      MessagesScreen.routeName);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 6.0),
                                  child: PopupMenuButton<String>(
                                    onSelected: (_) {},
                                    itemBuilder: (BuildContext context) {
                                      return {
                                        'إلغاء الطلب',
                                      }.map((String choice) {
                                        return PopupMenuItem<String>(
                                          height: 30,
                                          value: choice,
                                          child: Container(
                                            width: 100,
                                            child: Text(
                                              choice,
                                              style: GoogleFonts.cairo(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w600,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                            ),
                                          ),
                                        );
                                      }).toList();
                                    },
                                    child: Image.asset(
                                      'assets/icons/more_white.png',
                                      width: 23,
                                      height: 65,
                                    ),
                                  ),
                                ),
                              ),
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
                  Padding(
                    padding: const EdgeInsets.only(top: 4, left: 8.0),
                    child: Column(
                      children: [
                        SizedBox(height: 8),
                        InkWell(
                          onTap: () async {
                            await showInformationDialog(context);
                          },
                          child: Image.asset(
                            'assets/icons/add_bill.png',
                            width: 35,
                            height: 30,
                            fit: BoxFit.contain,
                          ),
                        ),
                        Text(
                          'إضافة فتورة',
                          style: GoogleFonts.cairo(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff0084ff),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 5),
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

// ignore: must_be_immutable
class BillInputs extends StatelessWidget {
  TextEditingController controller = TextEditingController();
  String label;
  bool readOnly;
  Function onChange;

  BillInputs({
    this.controller,
    this.label,
    this.readOnly,
    this.onChange,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: 120,
            height: 30,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50.0),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 4.0, left: 5),
                  child: Text(
                    'ر.س',
                    style: GoogleFonts.cairo(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.blue,
                    ),
                  ),
                ),
                Container(
                  width: 80,
                  height: 30,
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    controller: controller,
                    readOnly: readOnly,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'حقل فارغ';
                      } else {
                        return null;
                      }
                    },
                    onChanged: onChange,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.only(left: 10),
                      errorStyle: GoogleFonts.cairo(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 0.5,
                        ),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      border: InputBorder.none,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 15),
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Text(
              label,
              style: GoogleFonts.cairo(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
