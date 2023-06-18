import 'dart:async';

import 'package:socialnetworkplatform/FrontWidgets/Blocs/ConversationsBloc.dart';
import 'package:socialnetworkplatform/FrontWidgets/Blocs/MessageBloc.dart';
import 'package:socialnetworkplatform/FrontWidgets/Blocs/PostBloc.dart';
import 'package:socialnetworkplatform/FrontWidgets/Blocs/UserBloc.dart';
import 'package:socialnetworkplatform/FrontWidgets/Notification.dart';
import 'package:socialnetworkplatform/Models/Friend.dart';
import 'package:socialnetworkplatform/Models/Like.dart';
import 'package:socialnetworkplatform/Models/Message.dart';
import 'package:socialnetworkplatform/Models/Post.dart';
import 'package:socialnetworkplatform/Singleton.dart';

import '../Cache.dart';

class IncrementalDataProvider{
  static Future InitializeUpdater(){
    Cache.timer = Timer.periodic(const Duration(seconds:1), (timer) async => await GetUpdates());
  }
  static GetUpdates() async{
    var updates = await Singleton.socialNetworkRepo.GetUpdates();
    if(updates.Users.isNotEmpty || updates.Friends.isNotEmpty){
      if(updates.Users.isNotEmpty){
        Cache.Users = updates.Users;
      }
      if(updates.Friends.isNotEmpty){
        Cache.Friends = updates.Friends;
      }
      Cache.userBloc.add(new UserEvent(Cache.Users, Cache.Friends));
    }
    if(updates.Conversations.isNotEmpty){
      Cache.Conversations = updates.Conversations;
      Cache.conversationBloc.add(new ConversationEvent(updates.Conversations));
    }
    if(updates.Posts.isNotEmpty || updates.Likes.isNotEmpty){
      if(updates.Posts.isNotEmpty){
        Cache.Posts = updates.Posts;
      }
      if(updates.Likes.isNotEmpty){
        Cache.Likes = updates.Likes;
      }
      Cache.postBloc.add(new PostEvent(Cache.Posts, Cache.Likes));
    }
    if(updates.Messages.isNotEmpty){
      Cache.Messages = updates.Messages;
      Cache.messageBloc.add(new MessageEvent(updates.Messages));
    }
  }

  static void SendNotification(NotificationType notificationType, {Message message, Like like, Post post, Friend friend}){
    //Show popup
    //Add Notification to bloc
  }

}