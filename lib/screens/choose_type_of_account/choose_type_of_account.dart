import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tamer_amr/screens/register/register.dart';
import 'package:tamer_amr/screens/checked_user_login/check_user_login.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class ChooseTypeOfAccountScreen extends StatefulWidget {
  static const routeName = 'choose_type_of_account_screen';

  @override
  _ChooseTypeOfAccountScreenState createState() =>
      _ChooseTypeOfAccountScreenState();
}

class _ChooseTypeOfAccountScreenState extends State<ChooseTypeOfAccountScreen> {
  String typeOfUser = "0";
  String currentSelectedCity = "مدينة";
  String currentSelectedCityId = '1';
  final _formKey = GlobalKey<FormState>();
  final List<String> loadCity = [];
  final List loadCityData = [];
  TextEditingController identifyNumberController = TextEditingController();
  double _identifyNumbertextformHeight = 55;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    fechCity();
  }

  fechCity() async {
    const url = 'https://tomeramer.tameramr.com/api/data/city';
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Connection': 'keep-alive',
        },
      );
      if (response.statusCode == 200) {
        final extractData = json.decode(response.body) as Map<String, dynamic>;
        if (extractData == null) {
          return;
        }

        for (int i = 0; i < extractData['data'].length; i++) {
          loadCity.add(extractData['data'][i]['city']);
          loadCityData.add(extractData['data'][i]);
        }
        setState(() {});
      }
    } catch (error) {
      throw error;
    }
  }

  _submitForm(BuildContext context) {
    if (!_formKey.currentState.validate()) {
      return;
    } else if (currentSelectedCity == 'مدينة') {
      _scaffoldKey.currentState.showSnackBar(
        new SnackBar(
          backgroundColor: Color(0xff2190C6),
          duration: Duration(seconds: 2),
          content: new Text(
            'يجب اختيار مدينة',
            style: GoogleFonts.cairo(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: Theme.of(context).accentColor,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );

      return;
    } else {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => RegisterScreen(
          typeOfUser: typeOfUser,
          identifyNumber: identifyNumberController.text,
          currentSelectedCityId: currentSelectedCityId,
        ),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
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
                      width: deviceWidth * 1.5,
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
                  left: deviceWidth * 0.35,
                  child: Text(
                    "تسجيل حساب",
                    style: GoogleFonts.cairo(
                      fontSize: 35,
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).accentColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Positioned(
                  top: deviceWidth * 0.78,
                  left: deviceWidth * 0.33,
                  child: Text(
                    "يرجى اختيار نوع الحساب",
                    style: GoogleFonts.cairo(
                      fontSize: 23,
                      fontWeight: FontWeight.w300,
                      color: Theme.of(context).accentColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Positioned(
                    top: deviceWidth * 0.7,
                    left: deviceWidth * 0.2,
                    child: Container(
                      height: 300,
                      width: 300,
                      child: Row(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                typeOfUser = "0";
                                print(typeOfUser);
                              });
                            },
                            child: Container(
                              height: 100,
                              width: 120,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: typeOfUser == "0"
                                    ? Color(0xff2190C6)
                                    : Colors.transparent,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 3,
                                ),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Text(
                                "شخصى",
                                style: GoogleFonts.cairo(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).accentColor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          SizedBox(width: 50),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                typeOfUser = "1";
                                print(typeOfUser);
                              });
                            },
                            child: Container(
                              height: 100,
                              width: 120,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: typeOfUser == "1"
                                    ? Color(0xff2190C6)
                                    : Colors.transparent,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Text(
                                "مندوب      توصيل",
                                style: GoogleFonts.cairo(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).accentColor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
                typeOfUser == "1"
                    ? Positioned(
                        top: deviceWidth * 1.25,
                        left: deviceWidth * 0.17,
                        child: Container(
                          width: deviceWidth * 0.7,
                          height: _identifyNumbertextformHeight,
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: TextFormField(
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                              controller: identifyNumberController,
                              decoration: InputDecoration(
                                hintText: "رقم الهوية",
                                hintStyle: GoogleFonts.cairo(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  color: Theme.of(context).accentColor,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide: BorderSide(
                                    color: Theme.of(context).accentColor,
                                    width: 3.0,
                                  ),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide: BorderSide(
                                    color: Theme.of(context).accentColor,
                                    width: 3.0,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide: BorderSide(
                                    color: Theme.of(context).accentColor,
                                    width: 3.0,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide: BorderSide(
                                    color: Theme.of(context).accentColor,
                                    width: 3.0,
                                  ),
                                ),
                              ),
                              validator: (val) {
                                if (val.trim().isEmpty || val.length < 10) {
                                  setState(() {
                                    _identifyNumbertextformHeight = 75;
                                  });
                                  return "رقم الهوية غير صالح";
                                } else {
                                  setState(() {
                                    _identifyNumbertextformHeight = 55;
                                  });
                                  return null;
                                }
                              },
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ),
                      )
                    : Container(),
                Positioned(
                  top: deviceWidth * 1.42,
                  left: deviceWidth * 0.15,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Container(
                      width: deviceWidth * 0.74,
                      height: 75,
                      child: FormField<String>(
                        builder: (FormFieldState<String> state) {
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                              ),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 3,
                                ),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: DropdownButton<String>(
                                    itemHeight: 50,
                                    elevation: 0,
                                    isExpanded: false,
                                    hint: Text(
                                      currentSelectedCity,
                                      style: GoogleFonts.cairo(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: Theme.of(context).accentColor,
                                      ),
                                    ),
                                    dropdownColor: Color(0xff2190C6),
                                    iconEnabledColor: Colors.grey,
                                    isDense: true,
                                    icon: Icon(
                                      Icons.keyboard_arrow_down,
                                      size: 28,
                                      color: Theme.of(context).accentColor,
                                    ),
                                    onChanged: (String newValue) {
                                      setState(() {
                                        currentSelectedCity = newValue;
                                      });
                                      final item = loadCityData.firstWhere(
                                          (e) =>
                                              e['city'] == currentSelectedCity);
                                      print(item['id']);
                                      currentSelectedCityId =
                                          item['id'].toString();
                                    },
                                    items: loadCity.map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value ?? '',
                                        child: Text(
                                          value ?? '',
                                          style: GoogleFonts.cairo(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            color:
                                                Theme.of(context).accentColor,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: deviceWidth * 0.23,
                  child: InkWell(
                    onTap: () => _submitForm(context),
                    child: Container(
                      width: 250,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Theme.of(context).accentColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: Text(
                        "التالى",
                        style: GoogleFonts.cairo(
                          fontSize: 33,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff41A6BB),
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
      ),
    );
  }
}
