import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart' as intl;
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:tamer_amr/helpers/location.dart';
import 'package:tamer_amr/providers/orders_provider.dart';
import 'package:tamer_amr/providers/users_provider.dart';
import 'package:tamer_amr/screens/add_order/component/add_new_order_text.dart';
import 'package:tamer_amr/screens/add_order/component/delivery_place_textform.dart';
import 'package:tamer_amr/screens/add_order/component/order_details_text.dart';
import 'package:tamer_amr/screens/checked_user_login/check_user_login.dart';
import 'package:tamer_amr/screens/orders/orders.dart';
import 'package:tamer_amr/widgets/appbar.dart';
import 'package:tamer_amr/widgets/separator.dart';
import 'package:tamer_amr/widgets/bottom_navigation_widget.dart';
import 'package:tamer_amr/widgets/floating_action_button_widget.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class AddOrderScreen extends StatefulWidget {
  static const routeName = 'add_order_screen';
  String orderRecippt;
  String orderReciptAddress;
  AddOrderScreen({this.orderRecippt, this.orderReciptAddress});

  @override
  _AddOrderScreenState createState() => _AddOrderScreenState();
}

class _AddOrderScreenState extends State<AddOrderScreen> {
  String currentReceivedCity = "مدينة";
  String currentReceivedCityId = '1';
  String currentSendCity = "مدينة";
  String currentSendCityId = '1';
  String currentSelectCategory = "تصنيف";
  String currentSelectCategoryId = '1';
  final List<String> loadCity = [];
  final List loadCityData = [];
  final List<String> loadCategory = [];
  final List loadCategoryData = [];
  // TextEditingController _orderRecipptController = TextEditingController();
  // TextEditingController _orderReciptAddressController = TextEditingController();
  TextEditingController _orderDiscriptionController = TextEditingController();
  TextEditingController _priceFromController = TextEditingController();
  TextEditingController _priceToController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  DateTime selectDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  String actualTime = '0:00';
  String actualDate = '0/0/00';
  String accessToken;
  bool _isLoading = false;
  bool _isbuttonLoading = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      _isLoading = true;
    });
    fechCity();
    fechCategor();
    setState(() {
      _isLoading = false;
    });
  }

  fechCity() async {
    const url = 'https://tomeramer.tameramr.com/api/data/city';
    accessToken = Provider.of<Users>(context, listen: false)
        .prefes
        .getString('userToken');

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
        setState(() {});
      }
    } catch (error) {
      throw error;
    }
  }

  fechCategor() async {
    const url = 'https://tomeramer.tameramr.com/api/data/category';
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
          loadCategory.add(extractData['data'][i]['name']);
          loadCategoryData.add(extractData['data'][i]);
        }
        setState(() {});
      }
    } catch (error) {
      throw error;
    }
  }

  File _orderImage;

  final picker = ImagePicker();

  Future _pickOrderImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _orderImage = File(pickedFile.path);
      }
    });
  }

  _submitForm(BuildContext context) async {
    if (!_formKey.currentState.validate() ||
        actualTime == '0:00' ||
        actualDate == '0/0/00' ||
        _orderImage == null ||
        currentReceivedCity == "مدينة" ||
        currentSendCity == "مدينة" ||
        currentSelectCategory == "تصنيف") {
      await Fluttertoast.showToast(
        msg:
            'يجب التأكد من اختيار الوقت والتاريخ واختيار المدينة والتصنيف وارفاق الصورة',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    }
    try {
      setState(() {
        _isbuttonLoading = true;
      });

      await Provider.of<Orders>(context, listen: false).addOrder(
        placeReceipt: widget.orderRecippt,
        cityIdReceipt: currentReceivedCityId,
        cityIdSurrender: currentSendCityId,
        description: _orderDiscriptionController.text.trim(),
        photo: _orderImage,
        date: actualDate,
        time: actualTime,
        priceFrom: _priceFromController.text.trim(),
        priceTo: _priceToController.text.trim(),
        categoryId: currentSelectCategoryId,
        placeSurrender: widget.orderReciptAddress,
        accessToken: accessToken,
      );
      await Fluttertoast.showToast(
        msg: 'تم إنشاء الطلب بنجاح',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      setState(() {
        _isbuttonLoading = false;
      });

      Navigator.of(context).pushReplacementNamed(OrdersScreen.routeName);
    } catch (e) {
      await Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      setState(() {
        _isLoading = false;
      });
      setState(() {
        _isbuttonLoading = false;
      });
    }
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
      key: _scaffoldKey,
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Form(
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
                            height: deviceWidth * 0.63,
                            child: Stack(
                              children: [
                                _loadingMap
                                    ? Container(
                                        margin: EdgeInsets.only(top: 2),
                                        width: deviceWidth,
                                        height: deviceWidth * .65,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(15),
                                            bottomRight: Radius.circular(15),
                                          ),
                                        ),
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            backgroundColor:
                                                Theme.of(context).hoverColor,
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
                            children: [
                              AddNewOrderText(),
                              AddOrderDeliveryPlaceTextForm(
                                orderRecipptController: widget.orderRecippt,
                              ),
                              Directionality(
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
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                              color: Colors.grey[300],
                                            ),
                                          ),
                                          child: DropdownButtonHideUnderline(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: DropdownButton<String>(
                                                itemHeight: 50,
                                                elevation: 0,
                                                isExpanded: false,
                                                hint: Text(
                                                  currentReceivedCity,
                                                  style: GoogleFonts.cairo(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                isDense: true,
                                                dropdownColor: Colors.white,
                                                iconEnabledColor: Colors.grey,
                                                icon: Icon(
                                                  Icons.keyboard_arrow_down,
                                                  size: 28,
                                                  color: Theme.of(context)
                                                      .primaryColor
                                                      .withOpacity(0.7),
                                                ),
                                                onChanged: (String newValue) {
                                                  setState(() {
                                                    currentReceivedCity =
                                                        newValue;
                                                  });
                                                  final item = loadCityData
                                                      .firstWhere((e) =>
                                                          e['city'] ==
                                                          currentReceivedCity);
                                                  currentReceivedCityId =
                                                      item['id'].toString();
                                                },
                                                items: loadCity
                                                    .map((String value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value ?? '',
                                                    child: Text(
                                                      value ?? '',
                                                      style: GoogleFonts.cairo(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Theme.of(context)
                                                            .primaryColor,
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
                              ),
                              SizedBox(height: 5),
                              AddOrderDetailsText(),
                              Directionality(
                                textDirection: TextDirection.rtl,
                                child: Container(
                                  width: deviceWidth,
                                  height: 70,
                                  child: FormField<String>(
                                    builder: (FormFieldState<String> state) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                          right: 10.0,
                                          left: 10,
                                          bottom: 15,
                                        ),
                                        child: Container(
                                          padding: const EdgeInsets.all(10.0),
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                              color: Colors.grey[300],
                                            ),
                                          ),
                                          child: DropdownButtonHideUnderline(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: DropdownButton<String>(
                                                itemHeight: 50,
                                                elevation: 0,
                                                isExpanded: false,
                                                hint: Text(
                                                  currentSelectCategory,
                                                  style: GoogleFonts.cairo(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                dropdownColor: Colors.white,
                                                iconEnabledColor: Colors.grey,
                                                isDense: true,
                                                icon: Icon(
                                                  Icons.keyboard_arrow_down,
                                                  size: 28,
                                                  color: Theme.of(context)
                                                      .primaryColor
                                                      .withOpacity(0.7),
                                                ),
                                                onChanged: (String newValue) {
                                                  setState(() {
                                                    currentSelectCategory =
                                                        newValue;
                                                  });
                                                  final item = loadCategoryData
                                                      .firstWhere((e) =>
                                                          e['name'] ==
                                                          currentSelectCategory);
                                                  currentSelectCategoryId =
                                                      item['id'];
                                                },
                                                items: loadCategory
                                                    .map((String value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value ?? '',
                                                    child: Text(
                                                      value ?? '',
                                                      style: GoogleFonts.cairo(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Theme.of(context)
                                                            .primaryColor,
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
                              ),
                              Directionality(
                                textDirection: TextDirection.rtl,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: TextFormField(
                                    controller: _orderDiscriptionController,
                                    maxLines: 7,
                                    textCapitalization: TextCapitalization.none,
                                    enableSuggestions: false,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.only(right: 10, top: 8),
                                      hintText: 'تفاصيل الطلب',
                                      hintStyle: GoogleFonts.cairo(
                                        fontSize: 19,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey,
                                      ),
                                      filled: true,
                                      fillColor: Colors.white54,
                                      focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey[300]),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey[400], width: 1),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: BorderSide(
                                            color: Colors.grey[300], width: 1),
                                      ),
                                    ),
                                    validator: (val) {
                                      if (val.trim().isEmpty) {
                                        return "وصف الطلب غير صالح";
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  right: 8.0,
                                  left: 8,
                                  top: 15,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: _pickOrderImage,
                                      child: Container(
                                        padding: EdgeInsets.all(8),
                                        width: 200,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.grey[300],
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: Colors.white54,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Icon(
                                              Icons.cloud_upload,
                                              color: Colors.grey[400],
                                            ),
                                            Text(
                                              _orderImage == null
                                                  ? 'إرفاق صورة  '
                                                  : 'تم اختيار صورة ',
                                              style: GoogleFonts.cairo(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w400,
                                                color: Theme.of(context)
                                                    .primaryColor
                                                    .withOpacity(0.5),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Text(
                                      'صورة للطلب المراد إرسالة',
                                      style: GoogleFonts.cairo(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context)
                                            .primaryColor
                                            .withOpacity(0.5),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                              Directionality(
                                textDirection: TextDirection.rtl,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 5),
                                  child: TextFormField(
                                    style: GoogleFonts.cairo(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.orange,
                                    ),
                                    initialValue: widget.orderReciptAddress,
                                    textCapitalization: TextCapitalization.none,
                                    enableSuggestions: false,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(
                                        right: 10,
                                        top: 8,
                                        bottom: 5,
                                      ),
                                      hintText:
                                          ' يرجى اختيار عنوان مستلم الطلب من الخريطة',
                                      hintStyle: GoogleFonts.cairo(
                                        fontSize: 19,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.orange,
                                      ),
                                      filled: true,
                                      fillColor: Colors.white54,
                                      focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey[300]),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey[300], width: 1),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: BorderSide(
                                            color: Colors.grey[300], width: 1),
                                      ),
                                    ),
                                    validator: (val) {
                                      if (val.trim().isEmpty) {
                                        return "مكان الاستلام غير صالح";
                                      } else if (val.trim() ==
                                          'عنوان استلام الطلب') {
                                        return "مكان الاستلام غير صالح";
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ),
                              ),
                              Directionality(
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
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                              color: Colors.grey[300],
                                            ),
                                          ),
                                          child: DropdownButtonHideUnderline(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: DropdownButton<String>(
                                                itemHeight: 50,
                                                elevation: 0,
                                                isExpanded: false,
                                                hint: Text(
                                                  currentSendCity,
                                                  style: GoogleFonts.cairo(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                isDense: true,
                                                dropdownColor: Colors.white,
                                                iconEnabledColor: Colors.grey,
                                                icon: Icon(
                                                  Icons.keyboard_arrow_down,
                                                  size: 28,
                                                  color: Theme.of(context)
                                                      .primaryColor
                                                      .withOpacity(0.7),
                                                ),
                                                onChanged: (String newValue) {
                                                  setState(() {
                                                    currentSendCity = newValue;
                                                  });
                                                  final item = loadCityData
                                                      .firstWhere((e) =>
                                                          e['city'] ==
                                                          currentSendCity);
                                                  currentSendCityId =
                                                      item['id'];
                                                },
                                                items: loadCity
                                                    .map((String value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value ?? '',
                                                    child: Text(
                                                      value ?? '',
                                                      style: GoogleFonts.cairo(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Theme.of(context)
                                                            .primaryColor,
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
                              ),
                              Center(
                                child: Container(
                                  width: deviceWidth * .52,
                                  height: 45,
                                  alignment: Alignment.center,
                                  child: Text(
                                    'بيانات وصول الطرد والتكلفة',
                                    style: GoogleFonts.cairo(
                                      fontSize: 23,
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
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(8),
                                      width: 200,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.grey[300],
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white54,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: InkWell(
                                              onTap: () async {
                                                DateTime pickedData =
                                                    await showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime(
                                                      DateTime.now().year - 5),
                                                  lastDate: DateTime(
                                                      DateTime.now().year + 5),
                                                );
                                                if (pickedData != null)
                                                  setState(() {
                                                    selectDate = pickedData;
                                                    intl.DateFormat(
                                                            "dd-MM-yyyy")
                                                        .add_jm()
                                                        .format(selectDate);

                                                    actualDate = selectDate
                                                        .toString()
                                                        .substring(0, 10);
                                                  });
                                              },
                                              child: Text(
                                                actualDate,
                                                style: GoogleFonts.cairo(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600,
                                                  color: Theme.of(context)
                                                      .primaryColor
                                                      .withOpacity(0.5),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0),
                                            child: Text(
                                              'التاريخ',
                                              style: GoogleFonts.cairo(
                                                fontSize: 23,
                                                fontWeight: FontWeight.w600,
                                                color: Theme.of(context)
                                                    .primaryColor
                                                    .withOpacity(0.5),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(8),
                                      width: 200,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.grey[300],
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white54,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: InkWell(
                                              onTap: () async {
                                                TimeOfDay pickedTime =
                                                    await showTimePicker(
                                                  context: context,
                                                  initialTime: TimeOfDay.now(),
                                                );
                                                if (pickedTime != null)
                                                  setState(() {
                                                    selectedTime =
                                                        pickedTime.replacing(
                                                            hour: pickedTime
                                                                .hourOfPeriod);

                                                    actualTime =
                                                        '${(selectedTime.hour).toString() + ':' + (selectedTime.minute).toString() + '\t' + selectedTime.period.toString().substring(10, 12)}';
                                                  });
                                              },
                                              child: Text(
                                                actualTime,
                                                style: GoogleFonts.cairo(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600,
                                                  color: Theme.of(context)
                                                      .primaryColor
                                                      .withOpacity(0.5),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0),
                                            child: Text(
                                              'الوقــت',
                                              style: GoogleFonts.cairo(
                                                fontSize: 23,
                                                fontWeight: FontWeight.w600,
                                                color: Theme.of(context)
                                                    .primaryColor
                                                    .withOpacity(0.5),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 15),
                              Center(
                                child: Container(
                                  width: deviceWidth * .25,
                                  height: 40,
                                  alignment: Alignment.center,
                                  child: Text(
                                    'التكلفة',
                                    style: GoogleFonts.cairo(
                                      fontSize: 23,
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context).accentColor,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Color(0xff2190C2),
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(25.0),
                                      topLeft: Radius.circular(25.0),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(width: 8),
                                    Container(
                                      width: deviceWidth * 0.26,
                                      height: deviceWidth * 0.13,
                                      child: TextFormField(
                                        controller: _priceToController,
                                        textAlign: TextAlign.center,
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor:
                                              Theme.of(context).accentColor,
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.grey[300],
                                              width: 2.0,
                                            ),
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10),
                                            ),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.grey[300],
                                              width: 2.0,
                                            ),
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10),
                                            ),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.grey[300],
                                              width: 2.0,
                                            ),
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10),
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.grey[300],
                                              width: 2.0,
                                            ),
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10),
                                            ),
                                          ),
                                        ),
                                        validator: (val) {
                                          if (val.trim().isEmpty) {
                                            return "القيمة غير صالحة";
                                          } else if (int.parse(val.trim()) <
                                              int.parse(
                                                  _priceFromController.text)) {
                                            return "القيمة اصغر من الابتدائية ";
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 10.0),
                                      child: Text(
                                        'إلى',
                                        style: GoogleFonts.cairo(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w600,
                                          color: Theme.of(context)
                                              .primaryColor
                                              .withOpacity(0.6),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: deviceWidth * 0.27,
                                      height: deviceWidth * 0.13,
                                      child: TextFormField(
                                        controller: _priceFromController,
                                        textAlign: TextAlign.center,
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor:
                                              Theme.of(context).accentColor,
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.grey[300],
                                              width: 2.0,
                                            ),
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10),
                                            ),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.grey[300],
                                              width: 2.0,
                                            ),
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10),
                                            ),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.grey[300],
                                              width: 2.0,
                                            ),
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10),
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.grey[300],
                                              width: 2.0,
                                            ),
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10),
                                            ),
                                          ),
                                        ),
                                        validator: (val) {
                                          if (val.trim().isEmpty) {
                                            return "القيمة غير صالحة";
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 5, right: 8.0),
                                      child: Text(
                                        'من',
                                        style: GoogleFonts.cairo(
                                          fontSize: 23,
                                          fontWeight: FontWeight.w600,
                                          color: Theme.of(context)
                                              .primaryColor
                                              .withOpacity(0.6),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 15.0),
                                child: MySeparator(
                                  color: Colors.orange[200],
                                ),
                              ),
                              _isbuttonLoading
                                  ? Center(
                                      child: CircularProgressIndicator(
                                      backgroundColor:
                                          Theme.of(context).hoverColor,
                                    ))
                                  : Center(
                                      child: InkWell(
                                        onTap: () => _submitForm(context),
                                        child: Container(
                                          width: deviceWidth * .5,
                                          height: 65,
                                          alignment: Alignment.topCenter,
                                          child: Text(
                                            'إرسال طلبك',
                                            style: GoogleFonts.cairo(
                                              fontSize: 32,
                                              fontWeight: FontWeight.w600,
                                              color:
                                                  Theme.of(context).accentColor,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Color(0xff2190C2),
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(25.0),
                                              topLeft: Radius.circular(25.0),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                            ],
                          )
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
