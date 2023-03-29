import 'UserSQL.dart';

class Message{
  String ConversationID;
  String MessageContent;
  UserSQL MessageCreator;
  String Timestamp;
  Message({this.ConversationID,this.MessageContent,this.MessageCreator,this.Timestamp});
}