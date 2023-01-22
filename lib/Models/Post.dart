import '../Models/User.dart';

class Post{
  UserSQL UserPost;
  String PostPicUrl;
  List<UserSQL> Liked;
  Post({this.UserPost,this.PostPicUrl,this.Liked});
}