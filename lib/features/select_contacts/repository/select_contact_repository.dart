import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_ui/common/utils/utills.dart';
import 'package:whatsapp_ui/models/user_model.dart';
import 'package:whatsapp_ui/screens/mobile_chat_screen.dart';

final selectContactRepositoryProvider = Provider(
    (ref) => SelectContactRepository(firestore: FirebaseFirestore.instance));

class SelectContactRepository {
  final FirebaseFirestore firestore;

  SelectContactRepository({required this.firestore});

  Future<List<Contact>> getContacts() async {
    List<Contact> contacts = [];

    try {
      if (await FlutterContacts.requestPermission()) {
        contacts = await FlutterContacts.getContacts(withProperties: true);
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return contacts;
  }

  void selectContact(Contact selectedContact, BuildContext context) async {
    try {
      var userCollection = await firestore.collection('users').get();
      bool isFound = false;
      for (var doc in userCollection.docs) {
        var userData = UserModel.fromMap(doc.data());
        String selectedNum =
            selectedContact.phones[0].number.replaceAll(' ', '');
       // print(selectedContact.phones[1].number.toString()+'this is contact u looking for');
        if (selectedNum == userData.phoneNumber) {
          isFound = true;
          Navigator.pushNamed(context, MobileChatScreen.routeName,arguments: {
            'name' : userData.name,
            'uid' : userData.uid
          });
        }

        if (!isFound) {
          showSnackBar(
              context: context,
              content: 'this number not reg please do invite them');
        }
      }
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }
}
