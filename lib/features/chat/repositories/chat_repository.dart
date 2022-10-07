import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:whatsapp_ui/common/utils/utills.dart';
import 'package:whatsapp_ui/models/chat_contacts.dart';
import 'package:whatsapp_ui/models/user_model.dart';

class ChatRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  ChatRepository({required this.firestore, required this.auth});

  void sendTextMessage(
      {required BuildContext context,
      required String text,
      required String recieverUserId,
      required UserModel senderUser}) async {
    try {
      var timeSent = DateTime.now();
      UserModel receiverUserData;

      var userDataMap =
          await firestore.collection('users').doc(recieverUserId).get();
      receiverUserData = UserModel.fromMap(userDataMap.data()!);

      _saveDatatoContactsSubCollection(
          senderUser, receiverUserData, text, timeSent, recieverUserId);
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }


  void _saveMessageToMessageSubcollection(){

  }


  void _saveDatatoContactsSubCollection(
    UserModel senderUserData,
    UserModel recieverUserData,
    String text,
    DateTime timeSent,
    String recieverUserId,
  ) async {
    // reciver too current
    var recieverChatContact = ChatContacts(
        name: senderUserData.name,
        profilePic: senderUserData.profilePic,
        contactId: senderUserData.uid,
        timeSent: timeSent,
        lastMessage: text);

    await firestore
        .collection('users')
        .doc(recieverUserId)
        .collection('chats')
        .doc(auth.currentUser!.uid)
        .set(recieverChatContact.toMap());

    var senderChatContact = ChatContacts(
        name: recieverUserData.name,
        profilePic: recieverUserData.profilePic,
        contactId: recieverUserData.uid,
        timeSent: timeSent,
        lastMessage: text);

    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .doc(recieverUserId)
        .set(senderUserData.toMap());
  }
}
