import 'package:flutter/material.dart';
import 'package:tamer_amr/screens/notification/component/notification_items.dart';
import 'package:tamer_amr/widgets/appbar.dart';
import 'package:tamer_amr/widgets/bottom_navigation_widget.dart';
import 'package:tamer_amr/widgets/floating_action_button_widget.dart';

class NotificationScreen extends StatefulWidget {
  static const routeName = 'notification_screen';

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  Color _floatActionColor = Color(0xff86BED5);
  Color _iconSelectedColor = Color(0xffEBEBEB);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F4F5),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(55.0),
        child: AppBarWidget(),
      ),
      body: ListView(
        children: [
          NotificationItems(),
          NotificationItems(),
          NotificationItems(),
          NotificationItems(),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButtonWidget(
        floatActionColor: Color(0xff86BED5),
      ),
      bottomNavigationBar: BottomNavigationWidget(
        floatActionColor: _floatActionColor,
        iconSelectedColor: _iconSelectedColor,
      ),
    );
  }
}
