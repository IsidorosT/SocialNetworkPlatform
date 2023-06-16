import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Cache.dart';
import '../../Models/Conversation.dart';
import '../../Models/Message.dart';
import 'ConversationComponent.dart';

class MessageComponent extends StatelessWidget {
  Conversation Chat;
  String LastMessage;
  MessageComponent(Conversation chat){
    Chat = chat;
    messagesEx = Cache.Messages.where((x) => x.ConversationID == Chat.ConversationID).toList();
    LastMessage = messagesEx.length > 0 ? messagesEx.elementAt(messagesEx.length-1).MessageContent : "";
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
                        Cache.Users.where((x) => (x.UserID == Chat.UserIDB || x.UserID == Chat.UserIDB) && x.UserID != Cache.LoggedUser.UserID).elementAt(0).ProfilePicUrl
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
                                    text: LastMessage.length <= 20 ? LastMessage : LastMessage.substring(0,20)+"...",
                                    style: TextStyle(
                                      color: Colors.black,
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
