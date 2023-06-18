import 'package:socialnetworkplatform/Models/UserSQL.dart';

import '../Cache.dart';

class Notification{
  String UserID;
  NotificationType Type;

  Notification(this.UserID,this.Type);
  String GetNotificationString(){
    return Cache.Users.where((x) => x.UserID == UserID).elementAt(0).FullName + " " + MessageContent[Type];
  }

  Map<NotificationType,String> MessageContent = {
    NotificationType.SendMessage:"send you a message",
    NotificationType.LikePost:"like your post",
    NotificationType.UploadPost:"uploaded a new Post",
    NotificationType.AddFriend:"added you as Friend",
    NotificationType.RemoveFriend:"removed you from Friend",
  };
}

enum NotificationType{
  SendMessage,
  LikePost,
  UploadPost,
  AddFriend,
  RemoveFriend
}