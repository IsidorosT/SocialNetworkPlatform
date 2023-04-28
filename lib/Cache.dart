import 'package:flutter/cupertino.dart';
import 'package:socialnetworkplatform/Models/Conversation.dart';

import 'FrontWidgets/MainScreen.dart';
import 'Models/Friend.dart';
import 'Models/Like.dart';
import 'Models/Message.dart';
import 'Models/Post.dart';
import 'Models/UserSQL.dart';

class Cache{
  static UserSQL LoggedUser;
  static List<UserSQL> Users;
  static List<Post> Posts;
  static List<Friend> Friends;
  static List<Like> Likes;
  static List<Conversation> Conversations;
  static List<Message> Messages;
  static String Session;

  static State<MainScreen> MainScreenState;

  static List<Widget> TabViews;
}