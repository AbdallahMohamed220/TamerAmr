import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tamer_amr/models/offer_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tamer_amr/services/db.dart';
import 'dart:io' show Platform;

class Users with ChangeNotifier {
  SharedPreferences prefes;
  String usertoken;
  String name;
  String loginUseremail;
  String uid;
  String photo;
  String photoIdentity;
  String photoDrivingLicense;
  String phone;
  String userType;
  int points;
  int id;
  String editError = '';
  List<OfferModel> getOffer = [];
  FirebaseAuth _auth = FirebaseAuth.instance;
  User user;
  String fcmToken;
  Future<void> register({
    String username,
    String email,
    String phone,
    String password,
    String confirmpassword,
    String typeUser,
    String identityNumber,
    String cityId,
    File profilePhoto,
    File photoIdentity,
    File photoDrivingLicense,
  }) async {
    await registerUserWithEmailAndPassword(email, password,
        (String _uid) async {
      final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

      _firebaseMessaging.getToken().then((token) {
        print(token);
        fcmToken = token;
      });

      Map<String, String> userDataMap = {
        "uid": _uid,
        "userName": username,
        "userEmail": email,
        "userType": typeUser,
        "userCity": cityId,
      };

      await DBService.instance.addUserInfo(userDataMap, _uid);
    });

    const url = 'https://tomeramer.tameramr.com/api/auth/registers';

    var uri = Uri.parse(url);
    var request = new http.MultipartRequest("POST", uri);
    String mobileType;
    if (Platform.isIOS) {
      mobileType = "1";
    } else {
      mobileType = "2";
    }
    if (profilePhoto == null) {
      request.fields['name'] = username;
      request.fields['email'] = email;
      request.fields['phone'] = phone;
      request.fields['password'] = password;
      request.fields['c_password'] = confirmpassword;
      request.fields['typeUser'] = typeUser;
      request.fields['identity_number'] = identityNumber;
      request.fields['city_id'] = cityId;
      request.fields['mobile_type'] = mobileType;
      request.fields['fcm_token'] = fcmToken;

      Map<String, String> headers = {
        "Accept": "application/json",
      };

      request.headers.addAll(headers);
    } else {
      var stream1 =
          new http.ByteStream(DelegatingStream(profilePhoto.openRead()));
      var stream2 =
          new http.ByteStream(DelegatingStream(photoIdentity.openRead()));
      var stream3 =
          new http.ByteStream(DelegatingStream(photoDrivingLicense.openRead()));
      var length1 = await profilePhoto.length();
      var length2 = await profilePhoto.length();
      var length3 = await profilePhoto.length();

      var multipartFile1 = new http.MultipartFile(
        'photo',
        stream1,
        length1,
        filename: basename(
          profilePhoto.path,
        ),
      );
      var multipartFile2 = new http.MultipartFile(
        'PhotoIdentity',
        stream2,
        length2,
        filename: basename(
          photoIdentity.path,
        ),
      );
      var multipartFile3 = new http.MultipartFile(
        'PhotoDrivingLicense',
        stream3,
        length3,
        filename: basename(
          photoDrivingLicense.path,
        ),
      );
      Map<String, String> headers = {
        "Accept": "application/json",
      };

      request.headers.addAll(headers);

      request.files.add(multipartFile1);
      request.files.add(multipartFile2);
      request.files.add(multipartFile3);
      request.fields['name'] = username;
      request.fields['email'] = email;
      request.fields['phone'] = phone;
      request.fields['password'] = password;
      request.fields['c_password'] = confirmpassword;
      request.fields['typeUser'] = typeUser;
      request.fields['identity_number'] = identityNumber;
      request.fields['city_id'] = cityId;
      request.fields['fcm_token'] = fcmToken;
      request.fields['mobile_type'] = mobileType;
    }

    try {
      final response = await request.send();
      final respStr = await response.stream.bytesToString();
      print(json.decode(respStr));
      print(response.statusCode);
      if (response.statusCode != 200) {
        throw HttpException(
            ' هناك خطأ ما في إدخال البيانات يرجى التأكد من صحة البيانات');
      }
      // await request.send().then((response) async {
      //   print(response.statusCode);
      //   if (response.statusCode != 200) {
      //     throw HttpException(
      //         ' هناك خطأ ما في إدخال البيانات يرجى التأكد من صحة البيانات');
      //   }
      // response.stream.transform(utf8.decoder).listen((value) {
      //   final extractData = json.decode(value) as Map<String, dynamic>;
      //   if (extractData['code'] != 200) {
      //     print(extractData['message']);
      //     throw HttpException(extractData['message']);
      //   }
      // });
      // });
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> registerUserWithEmailAndPassword(String _email, String _password,
      Future<void> onSuccess(String _uid)) async {
    try {
      UserCredential _result = await _auth.createUserWithEmailAndPassword(
          email: _email.trim(), password: _password.trim());
      user = _result.user;
      print(user.uid);

      await onSuccess(user.uid);
    } catch (e) {
      print("e");
      print(e);
    }
  }

  Future<void> login({String email, String password}) async {
    const url = 'https://tomeramer.tameramr.com/api/auth/login';
    try {
      final response = await http.post(
        url,
        body: {
          'email': email,
          "password": password,
        },
      );

      final extractData = json.decode(response.body) as Map<String, dynamic>;
      if (extractData['code'] != 200) {
        throw HttpException(extractData['date'][0]);
      } else {
        print(email.trim());
        print(password.trim());
        // UserCredential _result = await _auth.signInWithEmailAndPassword(
        //     email: email.trim(), password: password.trim());
        // user = _result.user;

        // print("user.uid");
        // print(user.uid);
        // uid = user.uid;
        // print(uid);

        id = extractData['data']['id'];
        print('id');
        print(id);
        loginUseremail = extractData['data']['email'];
        print('email');
        print(loginUseremail);
        usertoken = extractData['data']['token'];
        name = extractData['data']['name'];
        photo = extractData['data']['photo'];
        userType = extractData['data']['userType2'];
        if (userType == "مندوب") {
          photoIdentity = extractData['data']['PhotoIdentity'];
          photoDrivingLicense = extractData['data']['PhotoDrivingLicense'];
        }
        points = extractData['data']['points'];

        notifyListeners();

        prefes = await SharedPreferences.getInstance();
        prefes.setString('userToken', extractData['data']['token']);
      }
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> updateUserData({
    String name,
    String oldPassword,
    String newPassword,
    String accessToken,
    File photo,
  }) async {
    const url = 'https://tomeramer.tameramr.com/api/update/account/user';
    var uri = Uri.parse(url);
    var stream1 = new http.ByteStream(DelegatingStream(photo.openRead()));

    var length1 = await photo.length();

    var multipartFile1 = new http.MultipartFile(
      'photo',
      stream1,
      length1,
      filename: basename(
        photo.path,
      ),
    );

    var request = new http.MultipartRequest("POST", uri);
    Map<String, String> headers = {
      "Authorization": "Bearer $accessToken",
      "Accept": "application/json",
    };

    request.headers.addAll(headers);
    request.files.add(multipartFile1);

    request.fields['name'] = name;
    request.fields['password'] = oldPassword;
    request.fields['newPassword'] = newPassword;

    try {
      await request.send().then((response) async {
        response.stream.transform(utf8.decoder).listen((value) {
          final extractData = json.decode(value) as Map<String, dynamic>;

          if (extractData['code'] != 200) {
            throw HttpException(extractData['date'][0]);
          }
        });
      });
    } on HttpException {
      throw HttpException('error');
    } catch (e) {
      throw e;
    }
  }

  Future<void> updateDeliveryData({
    String name,
    String oldPassword,
    String newPassword,
    String accessToken,
    File photo,
  }) async {
    const url = 'https://tomeramer.tameramr.com/api/update/account/delivery';
    var uri = Uri.parse(url);
    var stream1 = new http.ByteStream(DelegatingStream(photo.openRead()));
    var request = new http.MultipartRequest("POST", uri);

    var length1 = await photo.length();

    var multipartFile1 = new http.MultipartFile(
      'photo',
      stream1,
      length1,
      filename: basename(
        photo.path,
      ),
    );

    Map<String, String> headers = {
      "Authorization": "Bearer $accessToken",
      "Accept": "application/json",
    };

    request.headers.addAll(headers);
    request.files.add(multipartFile1);

    request.fields['name'] = name;
    request.fields['password'] = oldPassword;
    request.fields['newPassword'] = newPassword;

    try {
      await request.send().then((response) async {
        response.stream.transform(utf8.decoder).listen((value) {
          final extractData = json.decode(value) as Map<String, dynamic>;

          if (extractData['code'] != 200) {
            throw HttpException(extractData['date'][0]);
          }
        });
      });
    } catch (e) {
      throw e;
    }
  }

  fetchDelveriyOffer({String accessToken, int orderid}) async {
    print(orderid);
    String url =
        'https://tomeramer.tameramr.com/api/data/deliveries/offered/order/$orderid';

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );
      if (response.statusCode == 200) {
        final extractData = json.decode(response.body) as Map<String, dynamic>;
        print(extractData);
        if (extractData == null) {
          return;
        }

        for (int i = 0; i < extractData['data'][0].length; i++) {
          getOffer.add(
            OfferModel(
              id: extractData['data'][i][i]['id'],
              email: extractData['data'][i][i]['email'],
              name: extractData['data'][i][i]['name'],
              points: extractData['data'][i][i]['points'],
              photo: extractData['data'][i][i]['photo'],
              price: extractData['data'][i][i]['pivot']['price'],
              createdAt: extractData['data'][i][i]['pivot']['created_at'],
            ),
          );
        }
      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> contactUs({
    String fullName,
    String email,
    String subject,
    String phone,
  }) async {
    const url = 'https://tomeramer.tameramr.com/api/contactUs';
    try {
      final response = await http.post(
        url,
        body: {
          'fullName': fullName,
          'email': email,
          'subject': subject,
          'phone': phone,
        },
      );

      final extractData = json.decode(response.body) as Map<String, dynamic>;

      if (extractData['code'] != 200) {
        throw HttpException(extractData['date'][0]);
      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> logout() async {
    final prefes = await SharedPreferences.getInstance();
    prefes.clear();
  }
}
