import 'package:flutter/material.dart';
import 'package:tamer_amr/helpers/custom_dot.dart';
import 'package:tamer_amr/helpers/strings.dart';
import 'package:tamer_amr/screens/checked_user_login/check_user_login.dart';
import 'package:tamer_amr/screens/terms_of_use/terms_of_use.dart';
import 'package:tamer_amr/widgets/intro.dart';

class IntroScreen extends StatefulWidget {
  static const routeName = 'intro_screen';

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  PageController _pageController;
  int currentIndex = 0;
  List<Widget> _pages = [
    IntroScreenWidget(
      image: 'assets/images/intro-1.png',
      title: Strings.stepOneTitle,
      content: Strings.stepOneContent,
      subContent: Strings.stepOneSubContent,
      imagePosition: -360,
    ),
    IntroScreenWidget(
      image: 'assets/images/intro-2.png',
      title: Strings.stepOneTitle,
      content: Strings.stepTwoContent,
      subContent: Strings.stepTwoSubContent,
      imagePosition: -130,
    ),
    IntroScreenWidget(
      image: 'assets/images/intro-3.png',
      title: Strings.stepOneTitle,
      content: Strings.stepThreeContent,
      subContent: Strings.stepThreeSubContent,
      imagePosition: -30,
    ),
  ];
  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: deviceWidth,
        height: deviceHeight,
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
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            PageView(
              physics: NeverScrollableScrollPhysics(),
              onPageChanged: (int page) {
                setState(() {
                  currentIndex = page;
                });
              },
              controller: _pageController,
              children: <Widget>[
                _pages[currentIndex],
              ],
            ),
            Container(
              margin: EdgeInsets.only(bottom: 30),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(
                        () {
                          if (currentIndex == 0) {
                            currentIndex = 0;
                          } else {
                            currentIndex--;
                          }
                        },
                      );
                    },
                    icon: Container(
                      padding: EdgeInsets.only(
                        top: 5,
                        right: 6,
                        left: 4,
                        bottom: 5,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 3),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Image.asset(
                        'assets/images/arrow_back.png',
                        width: 20,
                      ),
                    ),
                  ),
                  Container(
                    child: CustomDotsIndicator(
                      dotsCount: 3,
                      position: currentIndex.toDouble(),
                      decorator: DotsDecorator(
                        color: Colors.transparent, // Inactive color
                        activeColor: Colors.white,
                        size: Size.square(12.0),
                        activeSize: Size.square(18.0),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (currentIndex == 2) {
                          Navigator.of(context)
                              .pushReplacementNamed(TermsOfUseScreen.routeName);
                        } else {
                          currentIndex++;
                        }
                      });
                    },
                    icon: Container(
                      padding: EdgeInsets.only(
                        top: 5,
                        right: 4,
                        left: 6,
                        bottom: 5,
                      ),
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 3),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Image.asset(
                        'assets/images/arrow_forward.png',
                        width: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
