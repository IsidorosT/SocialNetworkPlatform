import '../Models/UserSQL.dart';

class Conversation{
  String ConversationID;
  String UserIDA;
  String UserIDB;
  bool isUnread;
  Conversation({this.ConversationID,this.UserIDA,this.UserIDB,this.isUnread});
  Conversation.fromJson(Map<String, dynamic> json) {
    ConversationID = json['conversationID'];
    UserIDA = json['userIDA'];
    UserIDB = json['userIDB'];
    isUnread = json['isUnread'];
  }

  Map toJson() => {
    'ConversationID': ConversationID,
    'UserIDA': UserIDA,
    'UserIDB': UserIDB,
    'isUnread': isUnread,
  };
}