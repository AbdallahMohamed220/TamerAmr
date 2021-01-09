import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tamer_amr/screens/account/account.dart';
import 'package:tamer_amr/screens/more/more.dart';
import 'package:tamer_amr/screens/orders/orders.dart';
import 'package:tamer_amr/screens/shops/shops.dart';
import 'package:tamer_amr/widgets/bottom_navigation.dart';

// ignore: must_be_immutable
class BottomNavigationWidget extends StatefulWidget {
  int selectedTab;
  Color iconSelectedColor;
  Color floatActionColor;
  BottomNavigationWidget({
    this.selectedTab,
    this.iconSelectedColor,
    floatActionColor,
  });

  @override
  _BottomNavigationWidgetState createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  @override
  Widget build(BuildContext context) {
    return FABBottomAppBar(
      selectedIndex: widget.selectedTab,
      height: 77,
      centerItemText: '',
      color: Color(0xffEBEBEB),
      backgroundColor: Color(0xffEBEBEB),
      selectedColor: widget.iconSelectedColor,
      onTabSelected: (index) {
        setState(() {
          switch (index) {
            case 0:
              widget.floatActionColor = Color(0xff86BED5);
              widget.iconSelectedColor = Colors.blue;
              widget.selectedTab = index;
              Navigator.pushReplacement(
                  context,
                  new MaterialPageRoute(
                    builder: (context) => new MoreScreen(),
                  ));

              break;
            case 1:
              Navigator.pushReplacement(
                  context,
                  new MaterialPageRoute(
                    builder: (context) => new AccountScreen(),
                  ));
              widget.floatActionColor = Color(0xff86BED5);
              widget.iconSelectedColor = Colors.blue;
              widget.selectedTab = index;

              break;
            case 2:
              Navigator.pushReplacement(
                  context,
                  new MaterialPageRoute(
                    builder: (context) => new ShopsScreen(),
                  ));
              widget.floatActionColor = Color(0xff86BED5);
              widget.iconSelectedColor = Colors.blue;
              widget.selectedTab = index;

              break;
            case 3:
              Navigator.pushReplacement(
                  context,
                  new MaterialPageRoute(
                    builder: (context) => new OrdersScreen(),
                  ));
              widget.floatActionColor = Color(0xff86BED5);
              widget.iconSelectedColor = Colors.blue;
              widget.selectedTab = index;

              break;
          }
        });
      },
      items: [
        FABBottomAppBarItem(
          iconImage: Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Image.asset(
              'assets/icons/more_black.png',
              width: 30,
              height: 30,
            ),
          ),
          text: Container(
            margin: EdgeInsets.only(top: 6),
            child: Text(
              'المزيد',
              textAlign: TextAlign.center,
              style: GoogleFonts.cairo(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ),
        FABBottomAppBarItem(
          iconImage: Container(
              margin: EdgeInsets.only(top: 16, right: 5, left: 5),
              width: 35,
              height: 28,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/icons/avatar_black.png')))),
          text: Container(
            margin: EdgeInsets.only(right: 6, left: 4, top: 5),
            width: 50,
            child: Text(
              'إشتراكى',
              textAlign: TextAlign.center,
              style: GoogleFonts.cairo(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ),
        FABBottomAppBarItem(
          iconImage: Container(
              margin: EdgeInsets.only(top: 15, right: 5, left: 5),
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/icons/shop_black.png')))),
          text: Container(
            margin: EdgeInsets.only(left: 8, right: 5, top: 4),
            child: FittedBox(
              child: Text(
                'المتاجر القريبة',
                textAlign: TextAlign.center,
                style: GoogleFonts.cairo(
                  fontSize: 45,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ),
        ),
        FABBottomAppBarItem(
          iconImage: Container(
              margin: EdgeInsets.only(right: 5, top: 15),
              height: 30,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/icons/order_black.png')))),
          text: Container(
            margin: EdgeInsets.only(right: 5, top: 4),
            child: Text(
              'طلباتى',
              textAlign: TextAlign.center,
              style: GoogleFonts.cairo(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
