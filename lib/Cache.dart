import 'Models/Friend.dart';
import 'Models/Like.dart';
import 'Models/Post.dart';
import 'Models/UserSQL.dart';

class Cache{
  static UserSQL LoggedUser;
  static List<UserSQL> Users;
  static List<Post> Posts;
  static List<Friend> Friends;
  static List<Like> Likes;
  static String Session;
}