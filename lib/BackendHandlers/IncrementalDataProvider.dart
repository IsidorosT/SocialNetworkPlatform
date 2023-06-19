import 'dart:async';
import 'dart:js';

import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socialnetworkplatform/FrontWidgets/Blocs/ConversationsBloc.dart';
import 'package:socialnetworkplatform/FrontWidgets/Blocs/MessageBloc.dart';
import 'package:socialnetworkplatform/FrontWidgets/Blocs/NotificationBloc.dart';
import 'package:socialnetworkplatform/FrontWidgets/Blocs/PostBloc.dart';
import 'package:socialnetworkplatform/FrontWidgets/Blocs/UserBloc.dart';
import 'package:socialnetworkplatform/FrontWidgets/NotificationData.dart';
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
        var userID = GetFriendRequester(updates.Friends,Cache.Friends);
        if(updates.Friends.length > Cache.Friends.length){
          SendNotification(NotificationType.AddFriend,userID);
        } else{
          SendNotification(NotificationType.RemoveFriend,userID);
        }
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
        if(updates.Posts.length > Cache.Posts.length){
          var userID = GetPostCreatorRequester(updates.Posts,Cache.Posts);
          SendNotification(NotificationType.UploadPost,userID);
        }
        Cache.Posts = updates.Posts;
      }
      if(updates.Likes.isNotEmpty){
        if(updates.Likes.length > Cache.Likes.length){
          var userID = GetLikeRequester(updates.Likes,Cache.Likes);
          SendNotification(NotificationType.LikePost,userID);
        }
        Cache.Likes = updates.Likes;
      }
      Cache.postBloc.add(new PostEvent(Cache.Posts, Cache.Likes));
    }
    if(updates.Messages.isNotEmpty){
      var userID = GetMessageSender(updates.Messages,Cache.Messages);
      Cache.Messages = updates.Messages;
      Cache.messageBloc.add(new MessageEvent(updates.Messages));
      SendNotification(NotificationType.SendMessage,userID);
    }
  }

  static void SendNotification(NotificationType type,String userID){
    var notification = new NotificationData(userID,type,DateTime.now());
    //Show popup
    if(userID == Cache.LoggedUser.UserID || userID == ""){
      return;
    }
    CherryToast.info(
      title:  Text(notification.GetNotificationString()),
      iconWidget: CircleAvatar(
        radius: 16,
        backgroundImage: NetworkImage(
            Cache.Users.where((x) => x.UserID == notification.UserID).elementAt(0).ProfilePicUrl
        ),
      ),
    ).show(Cache.context);

    print("NotificationSent"+type.toString());
    //Add Notification to bloc
    var newNotifications = Cache.Notifications;
    newNotifications.add(notification);
    Cache.Notifications = List.empty(growable: true);
    Cache.Notifications.addAll(newNotifications);
    Cache.notificationBloc.add(new NotificationEvent(Cache.Notifications));
  }

  static String GetFriendRequester(List<Friend> newFriends, List<Friend> oldFriends){
    if(newFriends.length > oldFriends.length){
      return newFriends.where((x) => !oldFriends.any((y) => y.UserID == x.UserID && y.FriendUserID == x.FriendUserID)).elementAt(0).UserID;
    }
    else{
      var friend = oldFriends.where((x) => !newFriends.any((y) => y.UserID == x.UserID && y.FriendUserID == x.FriendUserID)).elementAt(0);
      return friend.UserID == Cache.LoggedUser.UserID ? friend.FriendUserID : friend.UserID;
    }
  }
  static String GetPostCreatorRequester(List<Post> newPosts, List<Post> oldPosts){
    if(newPosts.length > oldPosts.length){
      return newPosts.where((x) => !oldPosts.any((y) => y.PostID == x.PostID)).elementAt(0).UserID;
    }
    else{
      return "";
    }
  }
  static String GetLikeRequester(List<Like> newLikes, List<Like> oldLikes){
    if(newLikes.length > oldLikes.length){
      var like = newLikes.where((x) => !oldLikes.any((y) => y.PostID == x.PostID && y.UserID == x.UserID)).elementAt(0);
      if(Cache.Posts.where((x) => x.PostID == like.PostID).elementAt(0).UserID != Cache.LoggedUser.UserID){
        return "";
      }
      else {
        return like.UserID;
      }
    }
    else{
      return "";
    }
  }
  static String GetMessageSender(List<Message> newMessages, List<Message> oldMessages){
    if(newMessages.length > oldMessages.length){
      return newMessages.where((x) => !oldMessages.any((y) => y.MessageID == x.MessageID)).elementAt(0).Sender;
    }
    else{
      return "";
    }
  }
}
//if(type == NotificationType.SendMessage){
//      showTopSnackBar(
//        Overlay.of(Cache.context),
//        const CustomSnackBar.info(
//          message: "Someone send you a message",
//        ),
//      );
//    } else if(type == NotificationType.LikePost){
//      showTopSnackBar(
//        Overlay.of(Cache.context),
//        const CustomSnackBar.info(
//          message: "Someone liked your post",
//        ),
//      );
//    } else if(type == NotificationType.UploadPost){
//      showTopSnackBar(
//        Overlay.of(Cache.context),
//        const CustomSnackBar.info(
//          message: "Someone uploaded a new Post",
//        ),
//      );
//    } else if(type == NotificationType.AddFriend){
//      showTopSnackBar(
//        Overlay.of(Cache.context),
//        const CustomSnackBar.info(
//          message: "Someone added you as a Friend",
//        ),
//      );
//    } else if(type == NotificationType.RemoveFriend){
//      showTopSnackBar(
//        Overlay.of(Cache.context),
//        const CustomSnackBar.info(
//          message: "Someone removed you from friend",
//        ),
//      );
//    }