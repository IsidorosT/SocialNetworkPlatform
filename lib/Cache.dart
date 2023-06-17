import 'package:flutter/cupertino.dart';
import 'package:socialnetworkplatform/Models/Conversation.dart';

import 'FrontWidgets/Blocs/ConversationsBloc.dart';
import 'FrontWidgets/Blocs/MessageBloc.dart';
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

  static ConversationBloc conversationBloc;
  static MessageBloc messageBloc;

  static List<Widget> TabViews;

  static void Clear(){
    LoggedUser = null;
    Users = null;
    Posts = null;
    Friends = null;
    Likes = null;
    Conversations = null;
    Messages = null;
    Session = null;
    MainScreenState = null;
    conversationBloc = null;
    messageBloc = null;
    TabViews = null;
  }
}