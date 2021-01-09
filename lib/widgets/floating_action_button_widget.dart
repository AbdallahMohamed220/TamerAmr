import 'package:flutter/material.dart';
import 'package:tamer_amr/screens/check_user_type/check_user_type.dart';

// ignore: must_be_immutable
class FloatingActionButtonWidget extends StatefulWidget {
  Color floatActionColor;
  FloatingActionButtonWidget({
    this.floatActionColor,
  });

  @override
  _FloatingActionButtonWidgetState createState() =>
      _FloatingActionButtonWidgetState();
}

class _FloatingActionButtonWidgetState
    extends State<FloatingActionButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 60),
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: Color(0xffEBEBEB),
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(50.0),
          topRight: const Radius.circular(50.0),
        ), // BorderRadius
      ), // BoxDecoration
      child: GestureDetector(
          onTap: () {},
          child: Container(
            width: 50,
            height: 70,
            margin: const EdgeInsets.only(
              top: 15,
              right: 8,
              left: 8,
            ),
            decoration: BoxDecoration(
              color: widget.floatActionColor,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(50.0),
                topRight: const Radius.circular(50.0),
              ), // BorderRadius
            ),
            child: IconButton(
              icon: Image.asset(
                'assets/icons/home-run.png',
                width: 50,
              ),
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed(CheckUserTypeScreen.routeName);

                widget.floatActionColor = Colors.blue;
              },
            ),
          )),
    );
    // Container
  }
}
