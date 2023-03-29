import '../Models/UserSQL.dart';

class Conversation{
  String ConversationID;
  String LastMessage;
  bool isUnread;
  UserSQL RecipientUser;
  Conversation({this.ConversationID,this.LastMessage,this.isUnread,this.RecipientUser});
}