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
    return BlocBuilder<ConversationBloc, List<Conversation>>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                state.length > 0 ?
                ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: state.length,
                  itemBuilder: (context, index) {
                    var result = state[index];
                    return MessageComponent(result);
                  },
                )
                    :
                    Text(
                      "You have no active conversations yet!"
                    )
              ],
            ),
          );
        }
    );
  }
}
