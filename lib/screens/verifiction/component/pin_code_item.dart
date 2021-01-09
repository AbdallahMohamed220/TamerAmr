import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PinCodeItem extends StatelessWidget {
  TextEditingController pinCodeItemController = TextEditingController();
  PinCodeItem({this.pinCodeItemController});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      child: TextFormField(
        textAlign: TextAlign.center,
        maxLength: 1,
        decoration: InputDecoration(
          counterText: "",
          filled: true,
          fillColor: Theme.of(context).accentColor,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).accentColor,
              width: 3.0,
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
              color: Theme.of(context).accentColor,
              width: 3.0,
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}
