import 'dart:convert';

import '../Models/UserSQL.dart';

class Post{
  String UserID;
  String PostID;
  String PostPicUrl;
  String Description;
  Post();
  Post.fromJson(Map<String, dynamic> jsonstring) {
    UserID = jsonstring['userID'];
    PostID = jsonstring['postID'];
    PostPicUrl = jsonstring['postPicUrl'];
    Description = jsonstring['description'];
  }
  Map toJson() => {
    'UserID': UserID,
    'PostID': PostID,
    'PostPicUrl': PostPicUrl,
    'Description': Description
  };
}