class Like {
  String PostID;
  String UserID;

  Like();
  Like.fromJson(Map<String, dynamic> json){
    PostID = json['postID'];
    UserID = json['userID'];
  }
  Map toJson() => {
    'UserID': UserID,
    'PostID': PostID
  };
}