import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tamer_amr/screens/checked_user_login/check_user_login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tamer_amr/providers/users_provider.dart';
import 'package:tamer_amr/screens/verifiction/verifiction.dart';

// ignore: must_be_immutable
class UpLoadUserImagesScreen extends StatefulWidget {
  static const routeName = 'upload_user_images_screen';
  String usernamevalue;
  String emailvalue;
  String phoneNumbervalue;
  String passwordvalue;
  String confirmPasswordvalue;
  String typeOfUser;
  String identifyNumber;
  String currentSelectedCityId;

  UpLoadUserImagesScreen({
    this.usernamevalue,
    this.emailvalue,
    this.phoneNumbervalue,
    this.passwordvalue,
    this.confirmPasswordvalue,
    this.typeOfUser,
    this.identifyNumber,
    this.currentSelectedCityId,
  });

  @override
  _UpLoadUserImagesScreenState createState() => _UpLoadUserImagesScreenState();
}

class _UpLoadUserImagesScreenState extends State<UpLoadUserImagesScreen> {
  File _profileImage;
  File _identifyImage;
  File _drivingLicenseImage;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _isLoading = false;

  final picker = ImagePicker();

  Future _pickProfileImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _profileImage = File(pickedFile.path);
      }
    });
  }

  Future _pickIdentifyImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _identifyImage = File(pickedFile.path);
      }
    });
  }

  Future _pickDrivingLicenseImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _drivingLicenseImage = File(pickedFile.path);
      }
    });
  }

  _createAccount() async {
    if (_profileImage == null ||
        _identifyImage == null ||
        _drivingLicenseImage == null) {
      await Fluttertoast.showToast(
        msg: 'يجب إرفاق جميع الصور',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      return;
    } else {
      try {
        setState(() {
          _isLoading = true;
        });

        await Provider.of<Users>(context, listen: false).register(
          username: widget.usernamevalue,
          email: widget.emailvalue,
          phone: widget.phoneNumbervalue,
          password: widget.passwordvalue,
          confirmpassword: widget.confirmPasswordvalue,
          typeUser: widget.typeOfUser,
          identityNumber: widget.identifyNumber,
          cityId: widget.currentSelectedCityId,
          profilePhoto: _profileImage,
          photoIdentity: _identifyImage,
          photoDrivingLicense: _drivingLicenseImage,
        );
        Fluttertoast.showToast(
          msg: 'تم انشاء حساب بنجاح سيتم ارسال كود التفعيل',
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
        Future.delayed(
          const Duration(seconds: 2),
          () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => VerificationScreen(),
            ),
          ),
        );
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
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
                top: deviceWidth * 0.83,
                left: deviceWidth * 0.33,
                child: Text(
                  "إرفاق صورة شخصية",
                  style: GoogleFonts.cairo(
                    fontSize: 23,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).accentColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Positioned(
                top: deviceWidth * 0.95,
                left: deviceWidth * 0.27,
                child: InkWell(
                  onTap: _pickProfileImage,
                  child: Container(
                    padding: EdgeInsets.all(8),
                    width: 210,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xffF4F4F4),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          'assets/icons/upload.png',
                          width: 20,
                          height: 20,
                        ),
                        _profileImage == null
                            ? Text(
                                'إرفاق صورة',
                                style: GoogleFonts.cairo(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.5),
                                ),
                              )
                            : Text(
                                'تم إختيار صورة',
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
                ),
              ),
              Positioned(
                top: deviceWidth * 1.09,
                left: deviceWidth * 0.36,
                child: Text(
                  "إرفاق صورة الهوية",
                  style: GoogleFonts.cairo(
                    fontSize: 23,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).accentColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Positioned(
                top: deviceWidth * 1.2,
                left: deviceWidth * 0.27,
                child: InkWell(
                  onTap: _pickIdentifyImage,
                  child: Container(
                    padding: EdgeInsets.all(8),
                    width: 210,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xffF4F4F4),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          'assets/icons/upload.png',
                          width: 20,
                          height: 20,
                        ),
                        _identifyImage == null
                            ? Text(
                                'إرفاق صورة',
                                style: GoogleFonts.cairo(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.5),
                                ),
                              )
                            : Text(
                                'تم إختيار صورة',
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
                ),
              ),
              Positioned(
                top: deviceWidth * 1.35,
                left: deviceWidth * 0.3,
                child: Text(
                  "إرفاق صورة رخصة القيادة",
                  style: GoogleFonts.cairo(
                    fontSize: 23,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).accentColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Positioned(
                top: deviceWidth * 1.47,
                left: deviceWidth * 0.27,
                child: InkWell(
                  onTap: _pickDrivingLicenseImage,
                  child: Container(
                    padding: EdgeInsets.all(8),
                    width: 210,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xffF4F4F4),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          'assets/icons/upload.png',
                          width: 20,
                          height: 20,
                        ),
                        _drivingLicenseImage == null
                            ? Text(
                                'إرفاق صورة',
                                style: GoogleFonts.cairo(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.5),
                                ),
                              )
                            : Text(
                                'تم إختيار صورة',
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
                        onTap: _createAccount,
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
                            "تسجيل",
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
    );
  }
}
