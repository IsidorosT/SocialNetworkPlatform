import 'dart:async';

import 'package:socialnetworkplatform/FrontWidgets/Blocs/ConversationsBloc.dart';
import 'package:socialnetworkplatform/Models/Conversation.dart';
import 'package:socialnetworkplatform/Singleton.dart';

class IncrementalDataProvider{
  ConversationBloc _conversationBloc;
  Future InitializeUpdater(ConversationBloc conversationBloc){
    _conversationBloc = conversationBloc;
    var timer = new Timer.periodic(new Duration(seconds:1), GetUpdates());
  }
  GetUpdates() async{
    var updates = await Singleton.socialNetworkRepo.GetUpdates();
    if(updates.Users.isNotEmpty){

    }
    if(updates.Conversations.isNotEmpty){
      _conversationBloc.add(new ConversationEvent(updates.Conversations));
    }
    if(updates.Posts.isNotEmpty){

    }
    if(updates.Messages.isNotEmpty){

    }
    if(updates.Friends.isNotEmpty){

    }
    if(updates.Likes.isNotEmpty){

    }
  }
}