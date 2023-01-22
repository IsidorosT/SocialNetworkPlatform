import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Models/Conversation.dart';
import 'Components/MessageComponent.dart';
class MessageTab extends StatelessWidget {
  List<Conversation> Conversations;
  MessageTab(List<Conversation> conversations){
    Conversations = conversations;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: Conversations.length,
            itemBuilder: (context, index) {
              var result = Conversations[index];
              return MessageComponent(result);
            },
          )
        ],
      ),
    );
  }
}
