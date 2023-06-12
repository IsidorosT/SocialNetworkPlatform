class Friend{
  String UserID;
  String FriendUserID;

  Friend();
  Friend.fromJson(Map<String, dynamic> json) {
    UserID = json['userID'];
    FriendUserID = json['friendUserID'];
  }
  Map toJson() => {
    'UserID': UserID,
    'FriendUserID': FriendUserID
  };
}