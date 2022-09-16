import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_ui/common/widgets/loader.dart';
import 'package:whatsapp_ui/features/select_contacts/controller/select_contact_controller.dart';

class SelectContactsScreen extends ConsumerWidget {
  static const String routeName = '/select-contact';
  const SelectContactsScreen({Key? key}) : super(key: key);


  void selectContact(WidgetRef ref,Contact selectedContact,BuildContext context){
    ref.read(selectContactControllerProvider).selectContact(selectedContact, context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Select contact'),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.search)),
            IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))
          ],
        ),
        body: ref.watch(getContactsProvider).when(
              data: (contactList) {
                if (contactList.isNotEmpty) {
                  return ListView.builder(
                    itemCount: contactList.length,
                    itemBuilder: ((context, index) {
                    final contact = contactList[index];
                    return InkWell(
                      onTap: (() => selectContact(ref, contact, context)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text(contact.displayName),
                          leading: contact.photo == null ? CircleAvatar(backgroundColor: Colors.white,) : CircleAvatar(backgroundImage: MemoryImage(contact.photo!),),
                        ),
                      ),
                    );
                  }));
                } else {
                  return const Text("no contact bruh");
                }
              },
              error: ((error, stackTrace) => Text(error.toString())),
              loading: (() => const Loader()),
            ));
  }
}
