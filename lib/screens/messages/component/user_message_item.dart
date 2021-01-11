import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tamer_amr/models/conversation.dart';
import 'package:tamer_amr/screens/order_chat/component/delevery_chat.dart';

class UserMessageItem extends StatefulWidget {
  final Conversation conversation;

  const UserMessageItem({Key key, @required this.conversation}) : super(key: key);

  @override
  _UserMessageItemState createState() => _UserMessageItemState();
}

class _UserMessageItemState extends State<UserMessageItem> {
  String _userName;

  @override
  void initState() {
    super.initState();

    String userID = widget.conversation.ownerID;

    if (userID == FirebaseAuth.instance.currentUser.uid) userID = widget.conversation.receiverID;
    FirebaseFirestore.instance.collection("users").doc("$userID").get().then((doc) {
      setState(() {
        _userName = doc.data()["userName"];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0, left: 8, top: 10, bottom: 25),
      child: InkWell(
        onTap: () async {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) => DelveryChatScreen(
                conversation: widget.conversation,
                userName: this._userName,
              ),
            ),
          );
        },
        child: Material(
          elevation: 2,
          color: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Container(
            height: 130,
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Row(
                children: [
                  Container(
                    width: 90.0,
                    height: 90.0,
                    margin: EdgeInsets.only(right: 15),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          'assets/images/user_placeholder.png',
                        ),
                      ),
                      color: Colors.grey[300],
                      shape: BoxShape.circle,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        (_userName == null)
                            ? Center(child: CircularProgressIndicator())
                            : Text(
                                '$_userName',
                                style: GoogleFonts.cairo(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).accentColor,
                                ),
                              ),
                        Container(
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 10,
                                ),
                                child: Image.asset(
                                  'assets/icons/time-left.png',
                                  width: 15,
                                  height: 15,
                                  color: Theme.of(context).accentColor,
                                ),
                              ),
                              Text(
                                '${widget.conversation.lastMessageTime.toDate()}',
                                style: GoogleFonts.cairo(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).accentColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
