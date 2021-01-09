import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:tamer_amr/helpers/location.dart';
import 'package:tamer_amr/screens/add_order/add-order.dart';
import 'package:tamer_amr/screens/checked_user_login/check_user_login.dart';
import 'package:tamer_amr/screens/map/map.dart';
import 'package:tamer_amr/widgets/bottom_navigation_widget.dart';
import 'package:tamer_amr/widgets/floating_action_button_widget.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = 'home_screen';
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String senderAddress = '';
  String receiveAddress = '';

  Future<void> _selectSenderAddress() async {
    final locData = await Location().getLocation();
    final selectedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) => MapScreen(
          latitude: locData.latitude,
          longitude: locData.longitude,
          isSelecting: true,
        ),
      ),
    );
    if (selectedLocation == null) {
      return;
    }
    final pickAddress = await LocationHelper.getPlaceAddress(
        selectedLocation.latitude, selectedLocation.longitude);
    setState(() {
      senderAddress = pickAddress;
      print('senderAddress');
      print(senderAddress);
    });
  }

  Future<void> _selectRecevieAddress() async {
    final locData = await Location().getLocation();
    final selectedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) => MapScreen(
          latitude: locData.latitude,
          longitude: locData.longitude,
          isSelecting: true,
        ),
      ),
    );
    if (selectedLocation == null) {
      return;
    }
    final pickAddress = await LocationHelper.getPlaceAddress(
        selectedLocation.latitude, selectedLocation.longitude);
    setState(() {
      receiveAddress = pickAddress;
      print('receiveAddress');
      print(receiveAddress);
    });
  }

  String mapPreview;
  bool _loadedInitData = true;
  bool _loadingMap = false;

  Future<void> _getCurrentUserLocation() async {
    try {
      final locData = await Location().getLocation();
      print(locData.latitude);
      print(locData.longitude);
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
  void didChangeDependencies() async {
    if (_loadedInitData) {
      setState(() {
        _loadingMap = true;
      });

      _getCurrentUserLocation().then((_) {
        setState(() {
          _loadingMap = false;
        });
      });
    }

    _loadedInitData = false;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: deviceWidth,
        height: deviceHeight,
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: 2),
              height: deviceWidth * 0.5,
              child: AppBar(
                backgroundColor: Color(0xff2190c2),
                centerTitle: true,
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    icon: Image.asset(
                      'assets/icons/search.png',
                      width: 35,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                actions: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    height: 50.0,
                    width: MediaQuery.of(context).size.width / 2 - 50.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Badge(
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
                        Badge(
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
            _loadingMap
                ? Positioned(
                    top: deviceWidth * 0.2,
                    left: deviceWidth * 0.03,
                    right: deviceWidth * 0.03,
                    child: Container(
                      margin: EdgeInsets.only(top: 2),
                      width: deviceWidth,
                      height: deviceWidth * 1.6,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                      ),
                      child: Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Theme.of(context).hoverColor,
                        ),
                      ),
                    ),
                  )
                : Positioned(
                    top: deviceWidth * 0.2,
                    left: deviceWidth * 0.03,
                    right: deviceWidth * 0.03,
                    child: Container(
                      margin: EdgeInsets.only(top: 2),
                      width: deviceWidth,
                      height: deviceWidth * 1.6,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(mapPreview),
                        ),
                      ),
                    ),
                  ),
            Positioned(
              top: deviceWidth * 0.25,
              left: deviceWidth * 0.25,
              child: InkWell(
                onTap: _selectSenderAddress,
                child: Container(
                  width: deviceWidth * .72,
                  height: deviceWidth * .14,
                  alignment: Alignment.center,
                  child: Wrap(
                    direction: Axis.horizontal,
                    children: [
                      Text(
                        'قم بالضغط هنا لاعادة تحديد مكان ارسال الطلب ',
                        style: GoogleFonts.cairo(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).primaryColor,
                        ),
                        textAlign: TextAlign.right,
                      ),
                      Center(
                        child: Expanded(
                          child: FittedBox(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: Text(
                                senderAddress,
                                style: GoogleFonts.cairo(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.red,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30.0),
                      topLeft: Radius.circular(30.0),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: deviceWidth * 0.45,
              left: deviceWidth * 0.25,
              child: InkWell(
                onTap: _selectRecevieAddress,
                child: Container(
                  width: deviceWidth * .72,
                  height: deviceWidth * .14,
                  alignment: Alignment.center,
                  child: Wrap(
                    direction: Axis.horizontal,
                    children: [
                      Text(
                        'قم بالضغط هنا لاعادة تحديد مكان ارسال الطلب ',
                        style: GoogleFonts.cairo(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).primaryColor,
                        ),
                        textAlign: TextAlign.right,
                      ),
                      Center(
                        child: Expanded(
                          child: FittedBox(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: Text(
                                receiveAddress,
                                style: GoogleFonts.cairo(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.red,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30.0),
                      topLeft: Radius.circular(30.0),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: deviceWidth * 0.33,
              left: deviceWidth * 0.88,
              child: Column(
                children: [
                  Container(
                    height: 15,
                    width: 15,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 3,
                        color: Colors.orange,
                      ),
                    ),
                  ),
                  Dash(
                    direction: Axis.vertical,
                    length: 45,
                    dashLength: 5,
                    dashThickness: 3,
                    dashColor: Colors.orange,
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: deviceWidth * 0.25,
              child: InkWell(
                onTap: () {
                  //Navigator.of(context).pushNamed(AddOrderScreen.routeName);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => AddOrderScreen(
                        orderRecippt: senderAddress,
                        orderReciptAddress: receiveAddress,
                      ),
                    ),
                  );
                },
                child: Container(
                  width: deviceWidth * .49,
                  height: deviceWidth * .15,
                  alignment: Alignment.topCenter,
                  child: Text(
                    'طلب جديد',
                    style: GoogleFonts.cairo(
                      fontSize: 35,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).accentColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xff2190C2),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30.0),
                      topLeft: Radius.circular(30.0),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
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
