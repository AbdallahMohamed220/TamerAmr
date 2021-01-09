import 'package:flutter/material.dart';

class AccountContainerItem extends StatelessWidget {
  const AccountContainerItem({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _deviceWidth = MediaQuery.of(context).size.width;
    return Positioned(
      top: _deviceWidth * 0.25,
      left: _deviceWidth * 0.08,
      child: Container(
        width: _deviceWidth * 0.84,
        height: _deviceWidth * 0.46,
        decoration: BoxDecoration(
          color: Color(0xffEBEBEB),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
      ),
    );
  }
}
