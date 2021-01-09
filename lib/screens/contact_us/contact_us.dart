import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tamer_amr/models/http_exception.dart';
import 'package:tamer_amr/providers/users_provider.dart';
import 'package:tamer_amr/screens/checked_user_login/check_user_login.dart';
import 'package:tamer_amr/screens/edit_profile/component/textform.dart';
import 'package:tamer_amr/widgets/appbar.dart';

class ContactUsScreen extends StatefulWidget {
  static const routeName = 'contact_us_screen';
  ContactUsScreen({Key key}) : super(key: key);

  @override
  _ContactUsScreenState createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  TextEditingController _usernamecontroller = TextEditingController();
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _subjectcontroller = TextEditingController();
  TextEditingController _phonecontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  _submitForm(BuildContext context) async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    try {
      setState(() {
        _isLoading = true;
      });

      await Provider.of<Users>(context, listen: false).contactUs(
        fullName: _usernamecontroller.text.trim(),
        email: _emailcontroller.text.trim(),
        subject: _subjectcontroller.text.trim(),
        phone: _phonecontroller.text.trim(),
      );

      setState(() {
        _isLoading = false;
      });
      _usernamecontroller.clear();
      _emailcontroller.clear();
      _subjectcontroller.clear();
      _phonecontroller.clear();

      await Fluttertoast.showToast(
          msg: 'تم ارسال طلبك سيتم الاطلاع عليه والتواصل معك فى اقرب فرصة',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0);
    } on HttpException catch (e) {
      setState(() {
        _isLoading = false;
      });

      await Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } catch (e) {
      setState(() {
        _isLoading = false;
      });

      await Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(55.0),
        child: AppBarWidget(),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 30),
              Container(
                width: deviceWidth * 0.6,
                height: deviceWidth * 0.15,
                child: Text(
                  'للتواصل والابلاغ عن المشاكل يرجى تعبئة الحقول ببياتاتك الصحيحة',
                  style: GoogleFonts.cairo(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[700],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 30),
              TextFormWidget(
                hintText: 'الاسم بالكامل',
              ),
              SizedBox(height: 20),
              TextFormWidget(
                hintText: 'البريد الالكترونى',
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 13.0),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextFormField(
                    maxLines: 6,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.orange.withOpacity(0.045),
                      hintText: 'الموضوع',
                      hintStyle: GoogleFonts.cairo(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[400],
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey[300],
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.5),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              TextFormWidget(
                hintText: 'رقم الهاتف',
              ),
              SizedBox(height: 50),
              _isLoading
                  ? CircularProgressIndicator(
                      backgroundColor: Theme.of(context).hoverColor,
                    )
                  : InkWell(
                      onTap: () => _submitForm(context),
                      child: Container(
                        width: 250,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Color(0xff2190c2),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text(
                          "ارسال",
                          style: GoogleFonts.cairo(
                            fontSize: 33,
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).accentColor,
                          ),
                          textAlign: TextAlign.center,
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
