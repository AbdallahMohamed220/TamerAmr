import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:provider/provider.dart';
import 'package:tamer_amr/models/http_exception.dart';
import 'package:tamer_amr/providers/users_provider.dart';
import 'package:tamer_amr/screens/checked_user_login/check_user_login.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class HomePartnerShipItems extends StatefulWidget {
  Color color;
  String date;
  String time;
  String placeReceipt;
  String placeSurrender;
  int price;
  int orderId;
  HomePartnerShipItems({
    this.color,
    this.date,
    this.time,
    this.placeReceipt,
    this.placeSurrender,
    this.price,
    this.orderId,
  });

  @override
  _HomePartnerShipItemsState createState() => _HomePartnerShipItemsState();
}

class _HomePartnerShipItemsState extends State<HomePartnerShipItems> {
  TextEditingController _offerController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  _addOffer(BuildContext context) async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    setState(() {
      _isLoading = true;
    });
    String url =
        'http://tomeramer.tameramr.com/api/data/create/offer/${widget.orderId}';
    String accessToken = Provider.of<Users>(context, listen: false)
        .prefes
        .getString('userToken');
    print(widget.orderId);
    try {
      final response = await http.post(
        url,
        body: {
          'price': _offerController.text,
        },
        headers: {
          "Authorization": "Bearer $accessToken",
          "Accept": "application/json",
        },
      );
      final extractData = json.decode(response.body) as Map<String, dynamic>;
      print(extractData);
      if (response.statusCode != 200) {
        setState(() {
          _isLoading = false;
        });
        throw HttpException(extractData['message']);
      } else {
        setState(() {
          _isLoading = false;
        });
        await Fluttertoast.showToast(
          msg: 'تم قبول طلبك بنجاح',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      await Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          color: Colors.grey[200],
          child: ClipPath(
            clipper: ShapeBorderClipper(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Container(
              height: deviceWidth * 0.42,
              width: deviceWidth,
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: widget.color,
                    width: 20,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          widget.price.toString() + " Sr",
                          style: GoogleFonts.cairo(
                            fontSize: 28,
                            fontWeight: FontWeight.w600,
                            color: widget.color,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: Text(
                              'اليــــوم',
                              style: GoogleFonts.cairo(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: widget.color,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Text(
                            widget.time,
                            style: GoogleFonts.cairo(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: widget.color,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 10.0,
                          bottom: 8,
                        ),
                        child: Dash(
                          direction: Axis.vertical,
                          length: deviceWidth * 0.35,
                          dashLength: 8,
                          dashThickness: 2,
                          dashColor: widget.color,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 20),
                  Column(
                    children: [
                      Row(
                        children: [
                          Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 15),
                                height: 10,
                                width: 10,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    width: 2,
                                    color: widget.color,
                                  ),
                                ),
                              ),
                              Dash(
                                direction: Axis.vertical,
                                length: 35,
                                dashLength: 2,
                                dashThickness: 2,
                                dashColor: widget.color,
                              ),
                              Container(
                                height: 10,
                                width: 10,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    width: 2,
                                    color: widget.color,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 15,
                              top: 10.0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  width: deviceWidth * 0.5,
                                  height: 40,
                                  alignment: Alignment.topCenter,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Text(
                                      widget.placeReceipt,
                                      style: GoogleFonts.cairo(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: widget.color,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                  child: new Center(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 18.0),
                                      child: new Container(
                                        width: deviceWidth * 0.4,
                                        margin: new EdgeInsetsDirectional.only(
                                          start: 1.0,
                                          end: 1.0,
                                        ),
                                        height: 3.0,
                                        color: widget.color,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 8.0,
                                ),
                                Container(
                                  width: deviceWidth * 0.5,
                                  height: 30,
                                  alignment: Alignment.topCenter,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Text(
                                      widget.placeSurrender,
                                      style: GoogleFonts.cairo(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: widget.color,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () => _addOffer(context),
                              child: _isLoading
                                  ? CircularProgressIndicator(
                                      backgroundColor:
                                          Theme.of(context).hoverColor,
                                    )
                                  : Material(
                                      child: Container(
                                        width: 80,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          color: widget.color,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Text(
                                          'اضف عرض',
                                          style: GoogleFonts.cairo(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            color:
                                                Theme.of(context).accentColor,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: deviceWidth * 0.25,
                                height: deviceWidth * 0.14,
                                alignment: Alignment.center,
                                child: TextFormField(
                                  controller: _offerController,
                                  textAlignVertical: TextAlignVertical.center,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(10),
                                    hintText: "سعر ",
                                    hintStyle: GoogleFonts.cairo(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: widget.color,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                        color: widget.color,
                                        width: 3.0,
                                      ),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.red,
                                        width: 3.0,
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.red,
                                        width: 3.0,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                        color: widget.color,
                                        width: 3.0,
                                      ),
                                    ),
                                  ),
                                  validator: (val) {
                                    if (val.length == 0) {
                                      return "القيمة غير صالحة";
                                    } else if (int.parse(val) > widget.price) {
                                      return "القيمة اكبر من العرض";
                                    } else {
                                      return null;
                                    }
                                  },
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
