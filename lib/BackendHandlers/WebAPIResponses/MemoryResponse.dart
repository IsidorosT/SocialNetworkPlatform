import 'dart:convert';

import 'package:socialnetworkplatform/Models/Friend.dart';
import 'package:socialnetworkplatform/Models/Like.dart';
import 'package:socialnetworkplatform/Models/Post.dart';
import 'package:socialnetworkplatform/Models/UserSQL.dart';

class MemoryResponse {
  bool Success;
  List<Post> Posts;
  List<UserSQL> Users;
  List<Friend> Friends;
  List<Like> Likes;

  MemoryResponse({this.Success});
  MemoryResponse.fromJson(Map<String, dynamic> jsonstring){
    Success = jsonstring['success'];
    Iterable p = jsonstring['posts'];
    Posts = List<Post>.from(p.map((model)=> Post.fromJson(model)));
    Iterable u = jsonstring['users'];
    Users = List<UserSQL>.from(u.map((model)=> UserSQL.fromJson(model)));
    Iterable f = jsonstring['friends'];
    Friends = List<Friend>.from(f.map((model)=> Friend.fromJson(model)));
    Iterable l = jsonstring['likes'];
    Likes = List<Like>.from(l.map((model)=> Like.fromJson(model)));
  }
}