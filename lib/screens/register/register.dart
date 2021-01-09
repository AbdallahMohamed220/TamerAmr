import 'package:fluttertoast/fluttertoast.dart';
import 'package:tamer_amr/screens/checked_user_login/check_user_login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tamer_amr/providers/users_provider.dart';
import 'package:tamer_amr/screens/upload_user_images/upload_user_images.dart';
import 'package:tamer_amr/screens/verifiction/verifiction.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatefulWidget {
  static const routeName = 'register_screen';
  String typeOfUser;
  String identifyNumber;
  String currentSelectedCityId;
  RegisterScreen({
    this.typeOfUser,
    this.identifyNumber,
    this.currentSelectedCityId,
  });
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController usernameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController phoneNumberController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  double _usernametextformHeight = 55;
  double _emailtextformHeight = 55;
  double _phoneNumbertextformHeight = 55;
  double _passwordtextformHeight = 55;
  double _confirmPasswordtextformHeight = 55;

  bool _showPassword = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  _submitForm(BuildContext context) async {
    try {
      if (!_formKey.currentState.validate()) {
        return;
      }
      if (widget.typeOfUser == "0") {
        setState(() {
          _isLoading = true;
        });
        await Provider.of<Users>(context, listen: false).register(
          username: usernameController.text,
          email: emailController.text,
          phone: phoneNumberController.text,
          password: passwordController.text,
          confirmpassword: confirmPasswordController.text,
          typeUser: widget.typeOfUser,
          identityNumber: widget.identifyNumber,
          cityId: widget.currentSelectedCityId,
          profilePhoto: null,
          photoIdentity: null,
          photoDrivingLicense: null,
        );
        setState(() {
          _isLoading = false;
        });
        Fluttertoast.showToast(
          msg: 'تم انشاء حساب بنجاح سيتم ارسال كود التفعيل',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0,
        );

        Future.delayed(
          const Duration(seconds: 2),
          () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => VerificationScreen(),
            ),
          ),
        );
      } else {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => UpLoadUserImagesScreen(
            usernamevalue: usernameController.text,
            emailvalue: emailController.text,
            phoneNumbervalue: phoneNumberController.text,
            passwordvalue: passwordController.text,
            confirmPasswordvalue: confirmPasswordController.text,
            currentSelectedCityId: widget.currentSelectedCityId,
            typeOfUser: widget.typeOfUser,
            identifyNumber: widget.identifyNumber ?? " ",
          ),
        ));
      }
    } catch (e) {
      print(e);
      await Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      setState(() {
        _isLoading = false;
      });
    }
    // if (!_formKey.currentState.validate()) {
    //   return;
    // } else {
    //   if (widget.typeOfUser == "0") {
    //     try {
    //     setState(() {
    //       _isLoading = true;
    //     });
    //       await Provider.of<Users>(context, listen: false).register(
    //         username: usernameController.text,
    //         email: emailController.text,
    //         phone: phoneNumberController.text,
    //         password: passwordController.text,
    //         confirmpassword: confirmPasswordController.text,
    //         typeUser: widget.typeOfUser,
    //         identityNumber: widget.identifyNumber,
    //         cityId: widget.currentSelectedCityId,
    //         profilePhoto: null,
    //         photoIdentity: null,
    //         photoDrivingLicense: null,
    //       );

    // await Fluttertoast.showToast(
    //   msg: 'تم انشاء حساب بنجاح سيتم ارسال كود التفعيل',
    //   toastLength: Toast.LENGTH_SHORT,
    //   gravity: ToastGravity.BOTTOM,
    //   timeInSecForIosWeb: 3,
    //   backgroundColor: Colors.blue,
    //   textColor: Colors.white,
    //   fontSize: 16.0,
    // );
    // setState(() {
    //   _isLoading = false;
    // });
    // await Future.delayed(
    //   const Duration(seconds: 2),
    //   () => Navigator.of(context).push(
    //     MaterialPageRoute(
    //       builder: (context) => VerificationScreen(),
    //     ),
    //   ),
    // );
    //     } catch (e) {
    //       print(e);
    //       await Fluttertoast.showToast(
    //         msg: e.toString(),
    //         toastLength: Toast.LENGTH_SHORT,
    //         gravity: ToastGravity.BOTTOM,
    //         timeInSecForIosWeb: 3,
    //         backgroundColor: Colors.blue,
    //         textColor: Colors.white,
    //         fontSize: 16.0,
    //       );
    //       setState(() {
    //         _isLoading = false;
    //       });
    //     }
    //   } else {
    //     Navigator.of(context).push(MaterialPageRoute(
    //       builder: (context) => UpLoadUserImagesScreen(
    //         usernamevalue: usernameController.text,
    //         emailvalue: emailController.text,
    //         phoneNumbervalue: phoneNumberController.text,
    //         passwordvalue: passwordController.text,
    //         confirmPasswordvalue: confirmPasswordController.text,
    //         currentSelectedCityId: widget.currentSelectedCityId,
    //         typeOfUser: widget.typeOfUser,
    //         identifyNumber: widget.identifyNumber,
    //       ),
    //     ));
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            width: deviceWidth,
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
                  top: deviceWidth * 0.85,
                  left: deviceWidth * 0.15,
                  child: Container(
                    width: deviceWidth * 0.7,
                    height: _usernametextformHeight,
                    alignment: Alignment.center,
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextFormField(
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                        controller: usernameController,
                        decoration: InputDecoration(
                          suffixIcon: Container(
                            height: 30,
                            width: 20,
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Container(
                                    height: 25,
                                    width: 25,
                                    child: Image.asset(
                                      'assets/icons/avatar_white.png',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          hintText: "اسم المستخدم",
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
                          if (val.trim().isEmpty || val.length < 3) {
                            setState(() {
                              _usernametextformHeight = 72;
                            });
                            return "اسم المستخدم غير صالح";
                          } else {
                            setState(() {
                              _usernametextformHeight = 55;
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
                  top: deviceWidth * 1.01,
                  left: deviceWidth * 0.15,
                  child: Container(
                    width: deviceWidth * 0.7,
                    height: _emailtextformHeight,
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextFormField(
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                        controller: emailController,
                        decoration: InputDecoration(
                          suffixIcon: Container(
                            height: 30,
                            width: 20,
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Container(
                                    height: 25,
                                    width: 25,
                                    child: Image.asset('assets/icons/mail.png'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          hintText: "البريد الالكترونى",
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
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: deviceWidth * 1.17,
                  left: deviceWidth * 0.15,
                  child: Container(
                    width: deviceWidth * 0.7,
                    height: _phoneNumbertextformHeight,
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextFormField(
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                        controller: phoneNumberController,
                        decoration: InputDecoration(
                          suffixIcon: Container(
                            height: 30,
                            width: 20,
                            child: Row(
                              children: [
                                VerticalDivider(
                                  color: Theme.of(context).accentColor,
                                  thickness: 3,
                                ),
                                Text(
                                  "050",
                                  style: GoogleFonts.cairo(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: Theme.of(context).accentColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          hintText: "رقم الهاتف",
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
                          if (val.trim().isEmpty || val.length < 10) {
                            setState(() {
                              _phoneNumbertextformHeight = 72;
                            });
                            return "رقم الهاتف غير صالح";
                          } else {
                            setState(() {
                              _phoneNumbertextformHeight = 55;
                            });
                            return null;
                          }
                        },
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: deviceWidth * 1.33,
                  left: deviceWidth * 0.15,
                  child: Container(
                    width: deviceWidth * 0.7,
                    height: _passwordtextformHeight,
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextFormField(
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                        controller: passwordController,
                        obscureText: !_showPassword,
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
                                        'assets/icons/password.png',
                                      ),
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
                  top: deviceWidth * 1.49,
                  left: deviceWidth * 0.15,
                  child: Container(
                    width: deviceWidth * 0.7,
                    height: _confirmPasswordtextformHeight,
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextFormField(
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                        controller: confirmPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "تأكيد الرقم السرى",
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
                              _confirmPasswordtextformHeight = 72;
                            });
                            return "الرقم السرى غير متطابق";
                          } else if (val != passwordController.text) {
                            setState(() {
                              _confirmPasswordtextformHeight = 72;
                            });
                            return "الرقم السرى غير متطابق ";
                          } else {
                            setState(() {
                              _confirmPasswordtextformHeight = 55;
                            });
                            return null;
                          }
                        },
                        keyboardType: TextInputType.text,
                      ),
                    ),
                  ),
                ),
                _isLoading
                    ? Positioned(
                        bottom: 5,
                        left: deviceWidth * 0.5,
                        child: Center(child: CircularProgressIndicator()))
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
                            child: widget.typeOfUser == "0"
                                ? Text(
                                    "تسجيل",
                                    style: GoogleFonts.cairo(
                                      fontSize: 33,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff41A6BB),
                                    ),
                                    textAlign: TextAlign.center,
                                  )
                                : Text(
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
