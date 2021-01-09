import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:tamer_amr/helpers/location.dart';
import 'package:tamer_amr/screens/checked_user_login/check_user_login.dart';

class AddOrderMap extends StatefulWidget {
  AddOrderMap({Key key}) : super(key: key);

  @override
  _AddOrderMapState createState() => _AddOrderMapState();
}

class _AddOrderMapState extends State<AddOrderMap> {
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
    return _loadingMap
        ? Container(
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
            ),
            child: Center(
              child: CircularProgressIndicator(
                backgroundColor: Theme.of(context).hoverColor,
              ),
            ),
          )
        : Container(
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
            ),
            child: Image.network(
              mapPreview,
              fit: BoxFit.fill,
              width: double.infinity,
              height: deviceWidth * .65,
            ),
          );
  }
}
