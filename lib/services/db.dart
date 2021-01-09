import 'package:cloud_firestore/cloud_firestore.dart';

class DBService {
  static DBService instance = DBService();

  FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addUserInfo(userData, uid) async {
    try {
      return await _db.collection('users').doc(uid).set(userData);
    } catch (e) {
      print(e);
    }
  }

  getUserInfo(String email) async {
    return _db
        .collection("users")
        .where("userEmail", isEqualTo: email)
        .get()
        .catchError((e) {
      print(e.toString());
    });
  }

  Future<void> addChatRoom({
    senderId,
    receiveId,
    message,
  }) async {
    try {
      return await _db
          .collection("chat")
          .doc('ZOxC6YRaQXQx5a5g8eWR')
          .collection("massage")
          .add({
        "sender_id": senderId,
        "receive_id": receiveId,
        "message": message
      });
    } catch (e) {
      print(e);
    }
  }

  getChats() async {
    // var data = _db
    //     .collection("chats")
    //     .doc('ZOxC6YRaQXQx5a5g8eWR')
    //     .collection("message")
    //     .snapshots();

    // return data.map(
    //   (_doc) {
    //     print(_doc);
    //   },
    // );
    // var data = _db.collection("cars").snapshots();
    // print(data.doc[0].documentID); //this prints the document id of the (0th) first element in the collection of cars
  }

  Future<void> addMessage(String chatRoomId, chatMessageData) {
    _db
        .collection("chatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .add(chatMessageData)
        .catchError((e) {
      print(e.toString());
    });
  }

  getUserChats(String itIsMyName) async {
    return await _db
        .collection("chatRoom")
        .where('users', arrayContains: itIsMyName)
        .snapshots();
  }
}
