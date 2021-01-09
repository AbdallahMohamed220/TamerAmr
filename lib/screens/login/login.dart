import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tamer_amr/providers/users_provider.dart';
import 'package:tamer_amr/screens/check_user_type/check_user_type.dart';
import 'package:tamer_amr/screens/choose_type_of_account/choose_type_of_account.dart';
import 'package:tamer_amr/screens/checked_user_login/check_user_login.dart';

// ignore: must_be_immutable
class LoginScreen extends StatefulWidget {
  static const routeName = 'sign_in_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;
  bool _showPassword = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  double _emailtextformHeight = 55;
  double _passwordtextformHeight = 55;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  _submitForm(BuildContext context) async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    try {
      setState(() {
        _isLoading = true;
      });
      await Provider.of<Users>(context, listen: false).login(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      Navigator.of(context).pushReplacementNamed(CheckUserTypeScreen.routeName);
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      await Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
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
                  left: deviceWidth * 0.4,
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
                    "تسجيل دخول",
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
                  left: deviceWidth * 0.15,
                  child: Container(
                    width: deviceWidth * 0.7,
                    height: _emailtextformHeight,
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextFormField(
                        controller: emailController,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                        decoration: InputDecoration(
                          hintText: "البريد الالكترونى",
                          hintStyle: GoogleFonts.cairo(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).accentColor,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(35.0),
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
                          if (val.trim().isEmpty || !val.contains('@')) {
                            setState(() {
                              _emailtextformHeight = 72;
                            });
                            return "البريد الالكترونى غير صالح";
                          } else {
                            setState(() {
                              _emailtextformHeight = 55;
                            });
                            return null;
                          }
                        },
                        keyboardType: TextInputType.text,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: deviceWidth,
                  left: deviceWidth * 0.15,
                  child: Container(
                    width: deviceWidth * 0.7,
                    height: _passwordtextformHeight,
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextFormField(
                        controller: passwordController,
                        obscureText: !_showPassword,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                        decoration: InputDecoration(
                          suffixIcon: Container(
                            height: 30,
                            width: 20,
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        _showPassword = !_showPassword;
                                      });
                                    },
                                    child: Container(
                                      height: 25,
                                      width: 25,
                                      child: Image.asset(
                                          'assets/icons/password.png'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          hintText: "الرقم السرى",
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
                          if (val.trim().isEmpty) {
                            setState(() {
                              _passwordtextformHeight = 72;
                            });
                            return "الرقم السرى غير صالح";
                          } else if (val.length < 6) {
                            setState(() {
                              _passwordtextformHeight = 72;
                            });
                            return "الرقم السرى اقل من 6 احرف ";
                          } else {
                            setState(() {
                              _passwordtextformHeight = 55;
                            });
                            return null;
                          }
                        },
                        keyboardType: TextInputType.text,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: deviceWidth * 1.18,
                  left: deviceWidth * 0.38,
                  child: Text(
                    "هل نسيت الرقم السرى",
                    style: GoogleFonts.cairo(
                      fontSize: 19,
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).accentColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Positioned(
                  bottom: deviceWidth * 0.15,
                  left: deviceWidth * 0.42,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(ChooseTypeOfAccountScreen.routeName);
                    },
                    child: Text(
                      "تسجيل حساب",
                      style: GoogleFonts.cairo(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).primaryColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                _isLoading
                    ? Positioned(
                        bottom: 0,
                        left: deviceWidth * 0.5,
                        child: CircularProgressIndicator())
                    : Positioned(
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
                              "دخول",
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
