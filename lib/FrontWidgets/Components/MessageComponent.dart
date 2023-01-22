import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Cache.dart';
import '../../Models/Conversation.dart';
import '../../Models/Message.dart';
import 'ConversationComponent.dart';

class MessageComponent extends StatelessWidget {
  Conversation Chat;
  MessageComponent(Conversation chat){
    Chat = chat;
    messagesEx = [
      new Message(ConversationID: Chat.ConversationID,MessageContent: "Yeah let's go tommorow", MessageCreator: Chat.RecipientUser,Timestamp: "Now1"),
      new Message(ConversationID: Chat.ConversationID,MessageContent: "We were unlucky", MessageCreator: Chat.RecipientUser,Timestamp: "Now1"),
      new Message(ConversationID: Chat.ConversationID,MessageContent: "I have arrived but the bar is closed. Where are you ? Do you want to cancel it and come again tomorrow when even Eve will be here!", MessageCreator: Cache.LoggedUser,Timestamp: "Now1"),
      new Message(ConversationID: Chat.ConversationID,MessageContent: "Sure man i will be there at 8 o clock", MessageCreator: Cache.LoggedUser,Timestamp: "Now1"),
      new Message(ConversationID: Chat.ConversationID,MessageContent: "Will you join us tonight for drinks?", MessageCreator: Chat.RecipientUser,Timestamp: "Now1"),
      new Message(ConversationID: Chat.ConversationID,MessageContent: "hey", MessageCreator: Chat.RecipientUser,Timestamp: "Now1"),
      new Message(ConversationID: Chat.ConversationID,MessageContent: "hey", MessageCreator: Cache.LoggedUser,Timestamp: "Now1"),
      new Message(ConversationID: Chat.ConversationID,MessageContent: "hey", MessageCreator: Chat.RecipientUser,Timestamp: "Now1"),
      new Message(ConversationID: Chat.ConversationID,MessageContent: "hey", MessageCreator: Cache.LoggedUser,Timestamp: "Now1"),
      new Message(ConversationID: Chat.ConversationID,MessageContent: "hey", MessageCreator: Chat.RecipientUser,Timestamp: "Now1"),





    ];
  }

  List<Message> messagesEx;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>{
        Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MaterialApp(
              home: ConversationComponent(Chat,messagesEx)
            )
        ),
        )
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
          ),
          color: Colors.white,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 14,
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 16
                ).copyWith(right:0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundImage: NetworkImage(
                        Chat.RecipientUser.ProfilePicUrl
                    ),
                  ),
                  Container(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 8,
                            right:10,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Flexible(
                              child: RichText(
                                  overflow: TextOverflow.fade,
                                  strutStyle: StrutStyle(fontSize: 12.0),
                                  text: TextSpan(
                                    text: Chat.LastMessage.length <= 20 ? Chat.LastMessage : Chat.LastMessage.substring(0,20)+"...",
                                    style: TextStyle(
                                    fontWeight: Chat.isUnread ? FontWeight.bold : FontWeight.normal,
                                    )
                                  )

                              ),
                            )
                          ],
                        ),
                      )
                  ),
                ]
              ),
            )
          ],
        )
      ),
    );
  }
}
