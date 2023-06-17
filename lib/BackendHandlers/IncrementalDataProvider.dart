import 'dart:async';

import 'package:socialnetworkplatform/FrontWidgets/Blocs/ConversationsBloc.dart';
import 'package:socialnetworkplatform/FrontWidgets/Blocs/MessageBloc.dart';
import 'package:socialnetworkplatform/Singleton.dart';

import '../Cache.dart';

class IncrementalDataProvider{
  static Future InitializeUpdater(){
    Timer.periodic(const Duration(seconds:1), (timer) async => await GetUpdates());
  }
  static GetUpdates() async{
    var updates = await Singleton.socialNetworkRepo.GetUpdates();
    if(updates.Users.isNotEmpty){

    }
    if(updates.Conversations.isNotEmpty){
      Cache.Conversations = updates.Conversations;
      Cache.conversationBloc.add(new ConversationEvent(updates.Conversations));
    }
    if(updates.Posts.isNotEmpty){

    }
    if(updates.Messages.isNotEmpty){
      Cache.Messages = updates.Messages;
      Cache.messageBloc.add(new MessageEvent(updates.Messages));
    }
    if(updates.Friends.isNotEmpty){

    }
    if(updates.Likes.isNotEmpty){

    }
  }
}