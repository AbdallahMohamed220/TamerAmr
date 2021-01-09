import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tamer_amr/models/shop_model.dart';

class Shops with ChangeNotifier {
  List<ShopModel> getShops = [];

  fetchShops({String accessToken}) async {
    String url = 'https://tomeramer.tameramr.com/api/vendors';

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
        if (extractData == null) {
          return;
        }

        for (int i = 0; i < extractData['data'].length; i++) {
          print(extractData['data'][i]['name']);
          getShops.add(
            ShopModel(
              id: extractData['data'][i]['id'],
              name: extractData['data'][i]['name'],
              description: extractData['data'][i]['description'],
              photo: extractData['data'][i]['photo'],
              priceTo: extractData['data'][i]['price_to'],
              createdAt: extractData['data'][i]['created_at'],
            ),
          );
        }
      }
    } catch (error) {
      throw error;
    }
  }
}
