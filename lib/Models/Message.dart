import 'UserSQL.dart';

class Message{
  String MessageID;
  String ConversationID;
  String Sender;
  String MessageContent;
  DateTime SendDate;
  Message({this.MessageID,this.ConversationID,this.Sender,this.MessageContent,this.SendDate});
  Message.fromJson(Map<String, dynamic> json) {
    MessageID = json['messageID'];
    ConversationID = json['conversationID'];
    Sender = json['sender'];
    MessageContent = json['messageContent'];
    SendDate = DateTime.parse(json['sendDate']);
  }

  Map toJson() => {
    'MessageID': MessageID,
    'ConversationID': ConversationID,
    'Sender': Sender,
    'MessageContent': MessageContent,
    'SendDate': SendDate,
  };
}