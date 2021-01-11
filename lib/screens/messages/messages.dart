import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tamer_amr/models/conversation.dart';
import 'package:tamer_amr/screens/messages/component/user_message_item.dart';
import 'package:tamer_amr/widgets/appbar.dart';
import 'package:tamer_amr/widgets/bottom_navigation_widget.dart';
import 'package:tamer_amr/widgets/floating_action_button_widget.dart';

class MessagesScreen extends StatelessWidget {
  static const routeName = 'messages_screen';

  const MessagesScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(55.0),
        child: AppBarWidget(),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("conversations")
              .where("recipients", arrayContains: "${FirebaseAuth.instance.currentUser.uid}")
              .orderBy("lastMessageTime")
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Center(child: CircularProgressIndicator());
            else if (snapshot.data.docs.isEmpty)
              return Center(
                child: Text(
                  "لا يوجد رسائل",
                  style: GoogleFonts.cairo(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              );
            else
              return ListView(
                children: snapshot.data.docs.map<Widget>((doc) {
                  Conversation conversation = Conversation.fromDocument(doc);
                  return UserMessageItem(conversation: conversation);
                }).toList(),
              );
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButtonWidget(
        floatActionColor: Color(0xff86BED5),
      ),
      bottomNavigationBar: BottomNavigationWidget(
        floatActionColor: Color(0xff86BED5),
        iconSelectedColor: Colors.blue,
      ),
    );
  }
}
