import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tamer_amr/models/conversation.dart';
import 'package:tamer_amr/providers/users_provider.dart';
import 'package:tamer_amr/screens/order_chat/component/delevery_chat.dart';
import 'package:tamer_amr/screens/order_chat/component/user_chat.dart';

// ignore: must_be_immutable
class OrdersChatScreen extends StatefulWidget {
  static const routeName = 'orders_chat_screen';
  int id;
  String name;
  String photo;
  int price;
  int points;
  String createdAt;

  OrdersChatScreen({
    this.id,
    this.name,
    this.photo,
    this.price,
    this.createdAt,
    this.points,
  });

  @override
  _OrdersChatScreenState createState() => _OrdersChatScreenState();
}

class _OrdersChatScreenState extends State<OrdersChatScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tansactionHomePage();
  }

  tansactionHomePage() {
    Timer(Duration(seconds: 0), () async {
      String userType = Provider.of<Users>(context, listen: false).userType;
      String uid = Provider.of<Users>(context, listen: false).uid;
      print(uid);

      // TODO: all ids dynamic
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection("messages")
          .where("ownerID", isEqualTo: "YRZaM0hs4xVobD0R7N69OctGQkJ2")
          .where("receiverID", isEqualTo: "OpE5Bd9skghe9Cr5zZHzcPAdPqd2")
          .get();

      Conversation conversation = Conversation();

      if (snapshot.docs.isNotEmpty) {
        conversation = Conversation.fromDocument(snapshot.docs.first);
      }

      if (userType == 'مستخدم') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UserChatScreen(
              conversation: conversation,
              receiverID: "OpE5Bd9skghe9Cr5zZHzcPAdPqd2",
              id: widget.id,
              name: widget.name,
              photo: widget.photo,
              price: widget.price,
              points: widget.points,
              createdAt: widget.createdAt,
            ),
          ),
        );
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (BuildContext context) => UserChatScreen(
        //       id: widget.id,
        //       name: widget.name,
        //       photo: widget.photo,
        //       price: widget.price,
        //       points: widget.points,
        //       createdAt: widget.createdAt,
        //     ),
        //   ),
        // );
      } else {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => DelveryChatScreen(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE1E1E1),
    );
  }
}
