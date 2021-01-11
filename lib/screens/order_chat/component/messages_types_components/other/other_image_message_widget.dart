import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:tamer_amr/models/message.dart';
import 'package:tamer_amr/screens/checked_user_login/check_user_login.dart';

class OtherImageMessageWidget extends StatelessWidget {
  final Message message;

  const OtherImageMessageWidget({Key key, @required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Bubble(
      margin: BubbleEdges.only(top: 20, left: 20, right: deviceWidth * 0.15),
      alignment: Alignment.topLeft,
      nip: BubbleNip.leftTop,
      // nipWidth: 20,
      // nipHeight: 20,
      // nipRadius: 5.0,
      elevation: 0,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Image.network(
              "${this.message.content}",
            ),
            /*Align(
              alignment: Alignment.topRight,
              child: Image.asset(
                'assets/icons/check.png',
                width: 10,
                height: 10,
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}
