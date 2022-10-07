class ChatContacts {
  final String name;
  final String profilePic;
  final String contactId;
  final DateTime timeSent;
  final String lastMessage;

  ChatContacts(
      {
      required this.name,
      required this.profilePic,
      required this.contactId,
      required this.timeSent,
      required this.lastMessage});

   Map<String, dynamic> toMap() {
    return {
      'name': name,
      'profilePic': profilePic,
      'contactId': contactId,
      'timeSent': timeSent.microsecondsSinceEpoch,
      'lastMessage': lastMessage
    };
  }

    factory ChatContacts.fromMap(Map<String, dynamic> map) {
    return ChatContacts(
        name: map['name'] ?? '',
        lastMessage: map['lastMessage'] ?? '',
        profilePic: map['profilePic'] ?? '',
        contactId: map['contactId'] ?? '',
        timeSent: DateTime.fromMicrosecondsSinceEpoch(map['timesent']));
  } 
}
