import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tamer_amr/widgets/my_scrollbar.dart';
import 'package:http/http.dart' as http;

class AboutUsScreen extends StatefulWidget {
  static const routeName = 'about_us_screen';

  @override
  _AboutUsScreenState createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  String _aboutUs = 'يتم التحميل';
  @override
  void initState() {
    super.initState();

    fechAppIdea();
  }

  fechAppIdea() async {
    const url = 'https://tomeramer.tameramr.com/api/aboutUs?';
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
        setState(() {
          _aboutUs = extractData['data']['aboutUs'];
        });
      }
    } catch (error) {
      throw error;
    }
  }

  @override
  Widget build(BuildContext context) {
    final _deviceWidth = MediaQuery.of(context).size.width;
    final _deviceHeight = MediaQuery.of(context).size.height;
    final _scrollController = ScrollController();

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: _deviceHeight,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xff2190C6),
              Color(0xff209AA4),
            ],
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: -15,
              right: 80,
              child: Opacity(
                opacity: 0.1,
                child: Image.asset(
                  'assets/images/vesba-vevtor.png',
                  width: _deviceWidth * 1.5,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Opacity(
                opacity: 0.8,
                child: Image.asset(
                  'assets/images/saudi-arabia-building.png',
                  width: _deviceWidth,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: _deviceWidth * 0.15,
              left: _deviceWidth * 0.35,
              child: SizedBox(
                width: 150,
                height: 150,
                child: Image.asset(
                  'assets/images/logo.png',
                ),
              ),
            ),
            Positioned(
              top: _deviceWidth * 0.62,
              left: _deviceWidth * 0.12,
              child: Container(
                width: _deviceWidth * 0.75,
                height: _deviceWidth * 0.85,
                alignment: Alignment.topRight,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                    width: 3,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: MyScrollbar(
                  controller: _scrollController, // <---- Here, the controller
                  isAlwaysShown: true,
                  child: SingleChildScrollView(
                    controller: _scrollController, // <---- Here, the controller
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              right: 35.0,
                              top: 15,
                              left: 35,
                            ),
                            child: Text(
                              _aboutUs,
                              style: GoogleFonts.cairo(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
