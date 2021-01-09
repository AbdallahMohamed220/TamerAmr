import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tamer_amr/providers/users_provider.dart';
import 'package:tamer_amr/screens/checked_user_login/check_user_login.dart';
import 'package:tamer_amr/screens/edit_profile/component/username_textField.dart';
import 'package:tamer_amr/widgets/appbar.dart';
import 'package:tamer_amr/screens/edit_profile/component/backgound_image.dart';
import 'package:tamer_amr/screens/edit_profile/component/profileimage.dart';
import 'package:tamer_amr/widgets/separator.dart';
import 'package:tamer_amr/screens/edit_profile/component/textform.dart';
import 'package:tamer_amr/screens/edit_profile/component/title.dart';
import 'package:tamer_amr/widgets/bottom_navigation_widget.dart';
import 'package:tamer_amr/widgets/floating_action_button_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EditProfileScreen extends StatefulWidget {
  static const routeName = 'Edit_profile_screen';

  EditProfileScreen({Key key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  bool _isLoading = false;

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _oldPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  File _userImage;

  final picker = ImagePicker();

  Future _pickOrderImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _userImage = File(pickedFile.path);
      }
    });
  }

  _submitForm(BuildContext context) async {
    if (!_formKey.currentState.validate() || _userImage == null) {
      await Fluttertoast.showToast(
          msg: 'قم بتحديث اختيار الصورة',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }
    try {
      setState(() {
        _isLoading = true;
      });
      String accessToken = Provider.of<Users>(context, listen: false)
          .prefes
          .getString('userToken');
      String usertype = Provider.of<Users>(context, listen: false).userType;
      if (usertype == 'مستخدم') {
        await Provider.of<Users>(context, listen: false).updateUserData(
          name: _usernameController.text.trim(),
          oldPassword: _oldPasswordController.text.trim(),
          newPassword: _newPasswordController.text.trim(),
          photo: _userImage,
          accessToken: accessToken,
        );
      } else {
        await Provider.of<Users>(context, listen: false).updateDeliveryData(
          name: _usernameController.text.trim(),
          oldPassword: _oldPasswordController.text.trim(),
          newPassword: _newPasswordController.text.trim(),
          photo: _userImage,
          accessToken: accessToken,
        );
      }
      setState(() {
        _isLoading = false;
      });
      _usernameController.clear();
      _oldPasswordController.clear();
      _newPasswordController.clear();

      await Fluttertoast.showToast(
          msg: 'تم تعديل البيانات بنجاح',
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
    String userPhoto = Provider.of<Users>(context, listen: false).photo;
    String username = Provider.of<Users>(context, listen: false).name;
    return Scaffold(
      key: _scaffoldKey,
      body: Form(
        key: _formKey,
        child: Container(
          width: deviceWidth,
          height: deviceHeight,
          child: Stack(
            children: [
              Container(
                width: deviceWidth,
                height: deviceHeight,
                child: ListView(
                  children: [
                    Container(
                      width: deviceWidth,
                      height: deviceWidth * 0.88,
                      child: Stack(
                        children: [
                          BackgroundImage(
                            userPhoto: userPhoto,
                            userImage: _userImage,
                          ),
                          ProfileImageWidget(
                            userPhoto: userPhoto,
                            userImage: _userImage,
                          ),
                          Positioned(
                            top: deviceWidth * 0.7,
                            left: deviceWidth * 0.47,
                            child: InkWell(
                              onTap: () => _pickOrderImage(),
                              child: Container(
                                width: 35,
                                height: 35,
                                child: Image.asset('assets/icons/edit.png'),
                              ),
                            ),
                          ),
                          TitleWidget(
                            usrname: username ?? "",
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          // TextFormWidget(
                          //   hintText: "الاسم بالكامل",
                          // ),

                          SizedBox(height: 40),
                          // TextFormWidget(
                          //   hintText: "اسم المستخدم",
                          //   controller: _usernameController,
                          // ),

                          UserNameTextField(
                            hintText: "اسم المستخدم",
                            controller: _usernameController,
                            username: username,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 15.0,
                            ),
                            child: const MySeparator(
                              color: Color(0xffF8E6D1),
                            ),
                          ),
                          Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 50.0),
                                child: TextFormWidget(
                                  hintText: "كلمة المرور القديمة",
                                  controller: _oldPasswordController,
                                ),
                              ),
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
                          TextFormWidget(
                            hintText: "كلمة المرور الجديدة",
                            controller: _newPasswordController,
                          ),
                          SizedBox(height: 10),
                          Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: _isLoading
                                  ? CircularProgressIndicator(
                                      backgroundColor:
                                          Theme.of(context).hoverColor,
                                    )
                                  : InkWell(
                                      onTap: () => _submitForm(context),
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
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
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
