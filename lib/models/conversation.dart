import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/message.dart';

class Conversation {
  String id;
  final String lastMessage;
  final String ownerID;
  final String receiverID;
  final MessageType messageType;
  final int unseenOwnerCount;
  final int unseenReceiverCount;
  final Timestamp lastMessageTime;
  final List<String> recipients;

  Conversation({
    this.id,
    this.lastMessage,
    this.ownerID,
    this.receiverID,
    this.messageType,
    this.unseenOwnerCount,
    this.unseenReceiverCount,
    this.lastMessageTime,
    this.recipients,
  });

  factory Conversation.fromDocument(DocumentSnapshot doc) {
    var messageType;
    if (doc.data()["messageType"] != null) {
      switch (doc.data()["messageType"]) {
        case "text":
          messageType = MessageType.text;
          break;
        case "image":
          messageType = MessageType.image;
          break;
      }
    }
    return Conversation(
      id: doc.id,
      lastMessage: doc.data()["lastMessage"] != null ? doc.data()["lastMessage"] : "",
      ownerID: doc.data()["ownerID"],
      receiverID: doc.data()["receiverID"],
      messageType: messageType,
      unseenOwnerCount: doc.data()["unseenOwnerCount"],
      unseenReceiverCount: doc.data()["unseenReceiverCount"],
      lastMessageTime: doc.data()["lastMessageTime"] != null ? doc.data()["lastMessageTime"] : null,
      recipients: List<String>.from(doc.data()["recipients"]),
    );
  }

  Map<String, dynamic> toJSON() {
    return {
      "lastMessage": lastMessage,
      "ownerID": ownerID,
      "receiverID": receiverID,
      "messageType": messageType.toString().replaceAll("MessageType.", ""),
      "unseenOwnerCount": unseenOwnerCount,
      "unseenReceiverCount": unseenReceiverCount,
      "lastMessageTime": lastMessageTime,
      "recipients": recipients,
    };
  }
}
