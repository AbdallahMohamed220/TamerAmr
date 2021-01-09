import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:tamer_amr/screens/checked_user_login/check_user_login.dart';

// ignore: must_be_immutable
class AddOrderDeliveryPlaceOne extends StatefulWidget {
  String currentSelectedCity = "مدينة";
  String currentSelectedCityId = '1';
  AddOrderDeliveryPlaceOne(
      {this.currentSelectedCity, this.currentSelectedCityId});

  @override
  _AddOrderDeliveryPlaceOneState createState() =>
      _AddOrderDeliveryPlaceOneState();
}

class _AddOrderDeliveryPlaceOneState extends State<AddOrderDeliveryPlaceOne> {
  final List<String> loadCity = [];
  final List loadCityData = [];

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
      }
    } catch (error) {
      throw error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        width: deviceWidth,
        height: 75,
        child: FormField<String>(
          builder: (FormFieldState<String> state) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.03),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.grey[300],
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
                        widget.currentSelectedCity,
                        style: GoogleFonts.cairo(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      dropdownColor: Colors.white,
                      iconEnabledColor: Colors.grey,
                      value: 'currentCategorySelectValue',
                      isDense: true,
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        size: 28,
                        color: Theme.of(context).primaryColor.withOpacity(0.7),
                      ),
                      onChanged: (String newValue) {
                        setState(() {
                          widget.currentSelectedCity = newValue;
                        });
                        final item = loadCityData.firstWhere(
                            (e) => e['city'] == widget.currentSelectedCity);
                        widget.currentSelectedCityId = item['id'];
                      },
                      items: loadCity.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value ?? '',
                          child: Text(
                            value ?? '',
                            style: GoogleFonts.cairo(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).accentColor,
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
    );
  }
}
