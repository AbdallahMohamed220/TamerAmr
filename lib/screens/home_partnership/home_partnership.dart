import 'dart:convert';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:tamer_amr/screens/home_partnership/component/home_partnership_items.dart';
import 'package:tamer_amr/widgets/appbar.dart';
import 'package:tamer_amr/widgets/bottom_navigation_widget.dart';
import 'package:tamer_amr/widgets/floating_action_button_widget.dart';
import 'package:http/http.dart' as http;

class HomePartnerShipScreen extends StatefulWidget {
  static const routeName = 'home_partnership_screen';

  @override
  _HomePartnerShipScreenState createState() => _HomePartnerShipScreenState();
}

class _HomePartnerShipScreenState extends State<HomePartnerShipScreen> {
  List loadOrders = [];
  List<Color> ordersColor = [
    Colors.blue,
    Colors.orange,
    Colors.green,
    Colors.red,
    Colors.deepPurple,
    Colors.teal,
  ];
  bool _loadedInitData = true;
  bool _isLoading = true;

  @override
  void didChangeDependencies() async {
    if (_loadedInitData) {
      setState(() {
        _isLoading = true;
      });

      fechOrders().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }

    _loadedInitData = false;

    super.didChangeDependencies();
  }

  fechOrders() async {
    var url = 'https://tomeramer.tameramr.com/api/data/orders';
    SharedPreferences logindata = await SharedPreferences.getInstance();
    String userToken = logindata.getString('userToken');
    try {
      final response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $userToken",
          "Accept": "application/json",
        },
      );
      if (response.statusCode == 200) {
        final extractData = json.decode(response.body) as Map<String, dynamic>;
        if (extractData == null) {
          return;
        }

        var orderLength = extractData['data'][0].length;

        for (int i = 0; i < orderLength; i++) {
          loadOrders.add(extractData['data'][0]);
        }
        loadOrders.reversed.toList();
      }
    } catch (error) {
      throw error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(55.0),
        child: AppBarWidget(),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Theme.of(context).hoverColor,
              ),
            )
          : ListView.builder(
              itemCount: loadOrders.length,
              itemBuilder: (context, i) {
                Random random = new Random();
                int randomNumber = random.nextInt(5);

                return HomePartnerShipItems(
                  placeReceipt: loadOrders[i][i]['place_receipt'],
                  placeSurrender: loadOrders[i][i]['place_surrender'],
                  color: ordersColor[randomNumber],
                  date: loadOrders[i][i]['created_at']
                      .toString()
                      .substring(8, 10),
                  time: loadOrders[i][i]['created_at']
                      .toString()
                      .substring(11, 16),
                  price: loadOrders[i][i]['price_to'],
                  orderId: loadOrders[i][i]['id'],
                );
              }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButtonWidget(
        floatActionColor: Colors.blue,
      ),
      bottomNavigationBar: BottomNavigationWidget(
        floatActionColor: Color(0xff86BED5),
        iconSelectedColor: Colors.blue,
      ),
    );
  }
}
