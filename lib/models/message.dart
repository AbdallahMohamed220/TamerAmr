import 'package:cloud_firestore/cloud_firestore.dart';

enum MessageType { text, image }

class Message {
  final String id;
  final String senderID;
  final String content;
  final Timestamp timestamp;
  final MessageType messageType;
  final bool receiverSeen;

  Message({this.id, this.senderID, this.content, this.timestamp, this.messageType, this.receiverSeen});

  factory Message.fromDocument(DocumentSnapshot doc) {
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
    return Message(
      id: doc.id,
      senderID: doc.data()["senderID"],
      content: doc.data()["content"],
      messageType: messageType,
      receiverSeen: doc.data()["receiverSeen"],
      timestamp: doc.data()["timestamp"] != null ? doc.data()["timestamp"] : null,
    );
  }

  Map<String, dynamic> toJSON() {
    return {
      "senderID": senderID,
      "content": content,
      "messageType": messageType.toString().replaceAll("MessageType.", ""),
      "receiverSeen": receiverSeen,
      "timestamp": timestamp,
    };
  }
}
