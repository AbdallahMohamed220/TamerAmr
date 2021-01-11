import 'dart:convert';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:tamer_amr/helpers/location.dart';
import 'package:tamer_amr/providers/users_provider.dart';
import 'package:tamer_amr/screens/messages/messages.dart';
import 'package:tamer_amr/screens/notification/notification.dart';
import 'package:tamer_amr/screens/orders/component/orders_offers.dart';
import 'package:tamer_amr/widgets/bottom_navigation_widget.dart';
import 'package:tamer_amr/widgets/floating_action_button_widget.dart';
import 'package:tamer_amr/screens/checked_user_login/check_user_login.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class OrdersDescriptionScreen extends StatefulWidget {
  static const routeName = 'orders_description_screen';

  int orderId;

  OrdersDescriptionScreen({
    this.orderId,
  });

  @override
  _OrdersDescriptionScreenState createState() =>
      _OrdersDescriptionScreenState();
}

class _OrdersDescriptionScreenState extends State<OrdersDescriptionScreen> {
  bool _loadedInitData = true;
  bool _isloading = false;
  var extractData;
  @override
  void didChangeDependencies() async {
    if (_loadedInitData) {
      setState(() {
        _isloading = true;
      });
      _getCurrentUserLocation();
      fechOrderDetails().then((_) {
        setState(() {
          _isloading = false;
        });
      });
    }

    _loadedInitData = false;

    super.didChangeDependencies();
  }

  fechOrderDetails() async {
    String url =
        'https://tomeramer.tameramr.com/api/data/order/details/${widget.orderId}';
    String accessToken = Provider.of<Users>(context, listen: false)
        .prefes
        .getString('userToken');
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );
      if (response.statusCode == 200) {
        extractData = json.decode(response.body) as Map<String, dynamic>;
        if (extractData == null) {
          return;
        }
      }
    } catch (error) {
      throw error;
    }
  }

  String mapPreview;

  Future<void> _getCurrentUserLocation() async {
    try {
      final locData = await Location().getLocation();

      _showPreview(locData.latitude, locData.longitude);
    } catch (error) {
      return;
    }
  }

  _showPreview(double lat, double lng) {
    final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(
      latitude: lat,
      longitude: lng,
    );
    setState(() {
      mapPreview = staticMapImageUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isloading
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Theme.of(context).hoverColor,
              ),
            )
          : Container(
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
                          height: deviceWidth * 0.63,
                          child: Stack(
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 2),
                                width: deviceWidth,
                                height: deviceWidth * .65,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.grey[400],
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(15),
                                    bottomRight: Radius.circular(15),
                                  ),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(mapPreview),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(right: 15),
                              margin: EdgeInsets.only(right: 8),
                              width: deviceWidth * 0.55,
                              height: deviceWidth * 0.1,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                "عنوان مرسل الطلب",
                                style: GoogleFonts.cairo(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).accentColor,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.only(right: 15),
                              margin: EdgeInsets.only(right: 8),
                              width: deviceWidth,
                              height: deviceWidth * 0.1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Expanded(
                                    child: FittedBox(
                                      child: Text(
                                        extractData['data']['place_surrender'],
                                        style: GoogleFonts.cairo(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Image.asset(
                                    'assets/icons/place.png',
                                    width: 20,
                                    height: 30,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(right: 15),
                              margin: EdgeInsets.only(right: 8),
                              width: deviceWidth * 0.35,
                              height: deviceWidth * 0.1,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                "المدينة",
                                style: GoogleFonts.cairo(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).accentColor,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              alignment: Alignment.center,
                              width: deviceWidth * 0.4,
                              height: deviceWidth * 0.1,
                              child: Text(
                                extractData['data']['city_id_surrender']
                                    ['city'],
                                style: GoogleFonts.cairo(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(right: 15),
                              margin: EdgeInsets.only(right: 8),
                              width: deviceWidth * 0.5,
                              height: deviceWidth * 0.1,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                "الغرض من التوصيل",
                                style: GoogleFonts.cairo(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).accentColor,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              alignment: Alignment.topRight,
                              width: deviceWidth,
                              height: deviceWidth * 0.15,
                              child: FittedBox(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 20.0),
                                  child: Text(
                                    extractData['data']['description'],
                                    style: GoogleFonts.cairo(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(right: 15),
                              margin: EdgeInsets.only(right: 8),
                              width: deviceWidth * 0.55,
                              height: deviceWidth * 0.1,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                "تفاصيل الطلب",
                                style: GoogleFonts.cairo(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).accentColor,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              alignment: Alignment.topRight,
                              padding: EdgeInsets.only(right: 15),
                              margin: EdgeInsets.only(right: 20),
                              width: deviceWidth * 0.8,
                              height: deviceWidth * 0.2,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(
                                  20,
                                ),
                              ),
                              child: Text(
                                extractData['data']['description'],
                                style: GoogleFonts.cairo(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              alignment: Alignment.topRight,
                              margin: EdgeInsets.only(right: 30),
                              width: deviceWidth * 0.8,
                              height: deviceWidth * 0.015,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(
                                  20,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              alignment: Alignment.topRight,
                              margin: EdgeInsets.only(right: 30),
                              width: deviceWidth * 0.8,
                              height: deviceWidth * 0.4,
                              decoration: BoxDecoration(
                                color: Colors.grey[400],
                                borderRadius: BorderRadius.circular(
                                  20,
                                ),
                                image: DecorationImage(
                                  image: NetworkImage(
                                      extractData['data']['photo']),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(right: 15),
                              margin: EdgeInsets.only(right: 8),
                              width: deviceWidth * 0.55,
                              height: deviceWidth * 0.1,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                "عنوان المرسل له الطلب",
                                style: GoogleFonts.cairo(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).accentColor,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              alignment: Alignment.topRight,
                              padding: EdgeInsets.only(right: 15),
                              margin: EdgeInsets.only(right: 8),
                              width: deviceWidth,
                              height: deviceWidth * 0.1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Expanded(
                                    child: FittedBox(
                                      child: Text(
                                        extractData['data']['place_receipt'],
                                        style: GoogleFonts.cairo(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Image.asset(
                                    'assets/icons/place.png',
                                    width: 20,
                                    height: 30,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(right: 15),
                              margin: EdgeInsets.only(right: 8),
                              width: deviceWidth * 0.35,
                              height: deviceWidth * 0.1,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                "المدينة",
                                style: GoogleFonts.cairo(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).accentColor,
                                ),
                              ),
                            ),
                            SizedBox(height: 5),
                            Container(
                              alignment: Alignment.center,
                              width: deviceWidth * 0.4,
                              height: deviceWidth * 0.1,
                              child: Text(
                                extractData['data']['city_id_receipt']['city'],
                                style: GoogleFonts.cairo(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                            SizedBox(height: 5),
                            Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(right: 15),
                              margin: EdgeInsets.only(right: 8),
                              width: deviceWidth * 0.9,
                              height: deviceWidth * 0.1,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    "التاريخ",
                                    style: GoogleFonts.cairo(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context).accentColor,
                                    ),
                                  ),
                                  Container(
                                    width: 2,
                                    height: 40,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    "الوقت",
                                    style: GoogleFonts.cairo(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context).accentColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(right: 15),
                              margin: EdgeInsets.only(right: 8),
                              width: deviceWidth * 0.9,
                              height: deviceWidth * 0.1,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    extractData['data']['date'],
                                    style: GoogleFonts.cairo(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                  Text(
                                    extractData['data']['time'],
                                    style: GoogleFonts.cairo(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                            Center(
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          OrdersOffersScreen(
                                        orderId: widget.orderId,
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: deviceWidth * 0.6,
                                  height: deviceWidth * 0.1,
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    "مشاهدة كل العروض المقدمة",
                                    style: GoogleFonts.cairo(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context).accentColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 30),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: deviceWidth * 2.0,
                    height: 75,
                    child: ClipRRect(
                      clipBehavior: Clip.antiAlias,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20.0),
                          bottomRight: Radius.circular(20.0)),
                      child: AppBar(
                        automaticallyImplyLeading: false,
                        backgroundColor: Color(0xff2190c2),
                        centerTitle: true,
                        elevation: 0,
                        actions: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 8),
                            height: 50.0,
                            width: deviceWidth * 0.3,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).pushReplacementNamed(
                                        MessagesScreen.routeName);
                                  },
                                  child: Badge(
                                    badgeContent: Text(
                                      '3',
                                      style: GoogleFonts.cairo(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                    position: BadgePosition.topStart(
                                      top: -6,
                                    ),
                                    child: Icon(
                                      Icons.mail_outline,
                                      color: Colors.white,
                                      size: 35,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 20),
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).pushReplacementNamed(
                                        NotificationScreen.routeName);
                                  },
                                  child: Badge(
                                    badgeContent: Text(
                                      '3',
                                      style: GoogleFonts.cairo(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                    position: BadgePosition.topStart(
                                      top: -4,
                                    ),
                                    child: Icon(
                                      Icons.notifications,
                                      color: Colors.white,
                                      size: 35,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).pushReplacementNamed(
                                        MessagesScreen.routeName);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 6.0),
                                    child: PopupMenuButton<String>(
                                      onSelected: (_) {},
                                      itemBuilder: (BuildContext context) {
                                        return {
                                          'إلغاء الطلب',
                                        }.map((String choice) {
                                          return PopupMenuItem<String>(
                                            height: 30,
                                            value: choice,
                                            child: Container(
                                              width: 100,
                                              child: Text(
                                                choice,
                                                style: GoogleFonts.cairo(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w600,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                              ),
                                            ),
                                          );
                                        }).toList();
                                      },
                                      child: Image.asset(
                                        'assets/icons/more_white.png',
                                        width: 23,
                                        height: 65,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
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
