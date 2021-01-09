import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tamer_amr/models/message.dart';
import 'package:tamer_amr/screens/checked_user_login/check_user_login.dart';

class MineTextMessageWidget extends StatelessWidget {
  final Message message;

  const MineTextMessageWidget({Key key, @required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Bubble(
      margin: BubbleEdges.only(top: 20, right: 20, left: deviceWidth * 0.15),
      alignment: Alignment.topRight,
      nip: BubbleNip.rightTop,
      radius: Radius.circular(10.0),
      // nipWidth: 20,
      // nipHeight: 20,
      // nipRadius: 5.0,
      elevation: 0,
      color: Colors.blue,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "${this.message.content}",
              textAlign: TextAlign.right,
              style: GoogleFonts.cairo(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).accentColor,
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Icon(
                (message.receiverSeen) ? Icons.done_all : Icons.done,
                size: 18,
                color: Theme.of(context).accentColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
