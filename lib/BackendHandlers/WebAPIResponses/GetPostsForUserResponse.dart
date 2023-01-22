import 'package:socialnetworkplatform/Models/Post.dart';

class GetPostsForUserResponse{
  bool Success;
  List<Post> Posts;
  GetPostsForUserResponse(this.Success);

  GetPostsForUserResponse.fromJson(Map<String, dynamic> json) {
    Success = json['success'];
    Posts = json['posts'];
  }
}