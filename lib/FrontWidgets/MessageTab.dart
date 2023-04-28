import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialnetworkplatform/FrontWidgets/Blocs/ConversationsBloc.dart';
import '../Models/Conversation.dart';
import 'Components/MessageComponent.dart';
class MessageTab extends StatelessWidget {
  List<Conversation> Conversations;
  ConversationBloc conversationBloc;
  MessageTab(List<Conversation> conversations){
    Conversations = conversations;
  }

  @override
  Widget build(BuildContext context) {
    conversationBloc = BlocProvider.of<ConversationBloc>(context);
    BlocBuilder<ConversationBloc, List<Conversation>>(
        bloc: conversationBloc,
        builder: (context, state) {
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
    );
  }
}
