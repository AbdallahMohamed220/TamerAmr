import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:tamer_amr/models/order_model.dart';

class Orders with ChangeNotifier {
  List<OrderModel> getOrders = [];
  Future<void> addOrder({
    String placeReceipt,
    String cityIdReceipt,
    String cityIdSurrender,
    String description,
    String date,
    String time,
    String priceFrom,
    String priceTo,
    String categoryId,
    String placeSurrender,
    String accessToken,
    File photo,
  }) async {
    const url = 'http://tomeramer.tameramr.com/api/create/order';

    var uri = Uri.parse(url);
    var request = new http.MultipartRequest("POST", uri);

    var stream1 = new http.ByteStream(DelegatingStream(photo.openRead()));

    var length1 = await photo.length();
    String mobileType;
    if (Platform.isIOS) {
      mobileType = "1";
    } else {
      mobileType = "2";
    }

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

    request.fields['place_receipt'] = placeReceipt;
    request.fields['city_id_receipt'] = cityIdReceipt;
    request.fields['city_id_surrender'] = cityIdSurrender;
    request.fields['description'] = description;
    request.fields['date'] = date;
    request.fields['time'] = time;
    request.fields['price_from'] = priceFrom;
    request.fields['price_to'] = priceTo;
    request.fields['category_id'] = categoryId;
    request.fields['place_surrender'] = placeSurrender;
    request.fields['type'] = mobileType;

    try {
      // await request.send().then((response) async {
      //   response.stream.transform(utf8.decoder).listen((value) {
      //     final extractData = json.decode(value) as Map<String, dynamic>;
      //     print("extractData['code']");
      //     print(extractData['code']);
      //     if (extractData['code'] != 200) {
      //       throw HttpException(extractData['date'][0]);
      //     }
      //   });
      // });
      final response = await request.send();
      final respStr = await response.stream.bytesToString();
      print(json.decode(respStr));
      print(response.statusCode);
      if (response.statusCode != 200) {
        throw HttpException(
            ' هناك خطأ ما في إدخال البيانات يرجى التأكد من صحة البيانات');
      }
    } catch (e) {
      throw e;
    }
  }

  Future<void> getCompletedOrders({String accessToken}) async {
    String url = 'https://tomeramer.tameramr.com/api/data/my/orders/complete';

    try {
      final response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $accessToken",
          "Accept": "application/json",
        },
      );
      if (response.statusCode == 200) {
        final extractData = json.decode(response.body) as Map<String, dynamic>;
        if (extractData == null) {
          return;
        }
        for (int i = 0; i < extractData['data'][0].length; i++) {
          getOrders.add(
            OrderModel(
              id: extractData['data'][0][i]['id'],
              name: extractData['data'][0][i]['category_id']['name'],
              description: extractData['data'][0][i]['description'],
              photo: extractData['data'][0][i]['photo'],
              priceTo: extractData['data'][0][i]['price_to'],
              createdAt: extractData['data'][0][i]['created_at'],
            ),
          );
        }
      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> getNotCompletedOrders({String accessToken}) async {
    String url = 'https://tomeramer.tameramr.com/api/data/my/orders/UnComplete';

    try {
      final response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $accessToken",
          "Accept": "application/json",
        },
      );
      if (response.statusCode == 200) {
        final extractData = json.decode(response.body) as Map<String, dynamic>;

        if (extractData == null) {
          return;
        }

        for (int i = 0; i < extractData['data'][0].length; i++) {
          getOrders.add(
            OrderModel(
              id: extractData['data'][0][i]['id'],
              name: extractData['data'][0][i]['category_id']['name'],
              description: extractData['data'][0][i]['description'],
              photo: extractData['data'][0][i]['photo'],
              priceTo: extractData['data'][0][i]['price_to'],
              createdAt: extractData['data'][0][i]['created_at'],
            ),
          );
        }
        notifyListeners();
      }
    } catch (error) {
      throw error;
    }
  }
}
