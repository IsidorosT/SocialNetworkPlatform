import 'dart:html';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialnetworkplatform/Cache.dart';
import 'package:jiffy/jiffy.dart';
import 'package:socialnetworkplatform/FrontWidgets/Blocs/MessageBloc.dart';
import 'package:socialnetworkplatform/Singleton.dart';

import '../../Models/Conversation.dart';
import '../../Models/Message.dart';
import '../AppColors.dart';
import '../GlowingActionButton.dart';
import '../MainScreen.dart';

class ConversationComponent extends StatelessWidget {
  Conversation Chat;
  List<Message> Messages;
  ScrollController _controller;
  String MessageContent = "";
  ConversationComponent(Conversation chat,List<Message> messages){
    Chat = chat;
    messages.sort((a,b) => a.SendDate.compareTo(b.SendDate));
    Messages = messages;
    _controller = new ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    var textFieldController = new TextEditingController();
    return BlocProvider(
      create: (BuildContext context) => Cache.messageBloc,
      child: BlocBuilder<MessageBloc,List<Message>>(
        builder: (context, state) {
          Messages = state.where((x) => x.ConversationID == Chat.ConversationID).toList();
          Messages.sort((a,b) => a.SendDate.compareTo(b.SendDate));
          return Scaffold(
              appBar: AppBar(
                title: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      iconSize: 35,
                      onPressed: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MaterialApp(
                                home: MainScreen(1)))
                        )
                      },
                    ),
                    Text(Cache.Users.where((x) => (x.UserID == Chat.UserIDA || x.UserID == Chat.UserIDB) && x.UserID != Cache.LoggedUser.UserID).elementAt(0).FullName)
                  ],
                ),
              ),
              body: Container(
                width: double.maxFinite,
                height: double.maxFinite,
                color: Colors.teal,
                child: Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
                          controller: _controller,
                          child: Column(
                            children: [
                              ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: Messages.length,
                                reverse: false,
                                itemBuilder: (context, index) {
                                  var result = Messages[index];
                                  return result.Sender == Cache.LoggedUser.UserID
                                      ? MessageOwnTile( MessageContent: result.MessageContent, MessageDate: result.SendDate.toString())
                                      : MessageTile(MessageContent: result.MessageContent, MessageDate: result.SendDate.toString());
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SafeArea(
                      bottom: true,
                      top: false,
                      child: Container(
                        padding: EdgeInsets.only(top: 10,bottom: 5),
                        color: Colors.white,
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  right: BorderSide(
                                    width: 2,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.0),
                                child: Icon(
                                  CupertinoIcons.camera_fill,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 16.0),
                                child: TextField(
                                  controller: textFieldController,
                                  onChanged: (val) {
                                    MessageContent = val;
                                  },
                                  style: const TextStyle(fontSize: 14),
                                  decoration: const InputDecoration(
                                    hintText: 'Type something...',
                                    border: InputBorder.none,
                                  ),
                                  onSubmitted: (_) => {},//_sendMessage(),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 12,
                                right: 24.0,
                              ),
                              child: GlowingActionButton(
                                color: AppColors.accent,
                                icon: Icons.send_rounded,
                                onPressed: () async => {
                                  print('hit'),
                                  await Singleton.socialNetworkRepo.AddMessage(Chat.ConversationID,MessageContent),
                                  MessageContent = "",
                                  textFieldController.text = "",
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
          );
        }
      ),
    );
  }
}

/*
class ConversationComponent extends StatefulWidget {
  Conversation Chat;
  List<Message> Messages;
  ConversationComponent(Conversation chat,List<Message> messages){
    Chat = chat;
    Messages = messages;
  }

  @override
  State<ConversationComponent> createState() => _ConversationComponentState(Chat,Messages);
}

class _ConversationComponentState extends State<ConversationComponent> {
  Conversation Chat;
  List<Message> Messages;
  ScrollController _controller;
  String MessageContent = "";
  _ConversationComponentState(Conversation chat,List<Message> messages){
    Chat = chat;
    messages.sort((a,b) => a.SendDate.compareTo(b.SendDate));
    Messages = messages;
  }

  @override
  void initState() {
    super.initState();
    _controller = new ScrollController();
    //
  }

  @override
  Widget build(BuildContext context) {
    var textFieldController = new TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back),
              iconSize: 35,
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MaterialApp(
                      home: MainScreen(1)))
                )
              },
            ),
            Text(Cache.Users.where((x) => (x.UserID == Chat.UserIDA || x.UserID == Chat.UserIDB) && x.UserID != Cache.LoggedUser.UserID).elementAt(0).FullName)
          ],
        ),
      ),
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        color: Colors.teal,
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  controller: _controller,
                  child: Column(
                    children: [
                      ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: Messages.length,
                        reverse: false,
                        itemBuilder: (context, index) {
                          var result = Messages[index];
                          return result.Sender == Cache.LoggedUser.UserID
                          ? MessageOwnTile( MessageContent: result.MessageContent, MessageDate: result.SendDate.toString())
                          : MessageTile(MessageContent: result.MessageContent, MessageDate: result.SendDate.toString());
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
            SafeArea(
              bottom: true,
              top: false,
              child: Container(
                padding: EdgeInsets.only(top: 10,bottom: 5),
                color: Colors.white,
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(
                            width: 2,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Icon(
                          CupertinoIcons.camera_fill,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: TextField(
                          controller: textFieldController,
                          onChanged: (val) {
                            MessageContent = val;
                          },
                          style: const TextStyle(fontSize: 14),
                          decoration: const InputDecoration(
                            hintText: 'Type something...',
                            border: InputBorder.none,
                          ),
                          onSubmitted: (message) => {

                          },//_sendMessage(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 12,
                        right: 24.0,
                      ),
                      child: GlowingActionButton(
                        color: AppColors.accent,
                        icon: Icons.send_rounded,
                        onPressed: () async => {
                          print('hit'),
                          await Singleton.socialNetworkRepo.AddMessage(Chat.ConversationID,MessageContent),
                          MessageContent = "",
                          textFieldController.text = "",
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}
*/

class MessageTile extends StatelessWidget {
  String MessageContent;
  String MessageDate;
  static const _borderRadius = 26.0;
  MessageTile({this.MessageContent,this.MessageDate});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(_borderRadius),
                  topRight: Radius.circular(_borderRadius),
                  bottomRight: Radius.circular(_borderRadius),
                ),
              ),
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
                child: Text(MessageContent ?? ''),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                MessageDate,
                style: const TextStyle(
                  color: AppColors.textFaded,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MessageOwnTile extends StatelessWidget {
  String MessageContent;
  String MessageDate;
  static const _borderRadius = 26.0;
  MessageOwnTile({this.MessageContent,this.MessageDate});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: AppColors.secondary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(_borderRadius),
                  bottomRight: Radius.circular(_borderRadius),
                  bottomLeft: Radius.circular(_borderRadius),
                ),
              ),
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
                child: Text(MessageContent ?? '',
                    style: const TextStyle(
                      color: AppColors.textLigth,
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                MessageDate,
                style: const TextStyle(
                  color: AppColors.textFaded,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}




