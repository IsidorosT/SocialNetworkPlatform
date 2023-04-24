import 'package:socialnetworkplatform/Models/Conversation.dart';

import 'Post.dart';

class UserSQL {
  String UserID;
  String Name;
  String Surname;
  String FullName;
  DateTime DateOfBirth;
  String Email;
  String Password;
  String Bio;
  String ProfilePicUrl;
  UserSQL(this.UserID,this.Name,this.Surname,this.DateOfBirth,this.Email,this.Password,this.Bio, this.ProfilePicUrl){
    FullName = Name + " " + Surname;
  }
  UserSQL.fromJson(Map<String,dynamic> json){
    UserID = json['userID'];
    Name = json['name'];
    Surname = json['surname'];
    FullName = Name + " " + Surname;
    DateOfBirth = DateTime.parse(json['dateOfBirth']);
    Email = json['email'];
    Password = json['password'];
    Bio = json['bio'];
    ProfilePicUrl = json['profilePicUrl'];
  }
  Map toJson() => {
    'Name': Name,
    'Surname': Surname,
    'DateOfBirth': DateOfBirth,
    'Email': Email,
    'Password': Password,
    'Bio': Bio,
    'ProfilePicUrl': ProfilePicUrl
  };
}

class User{
  String UserID;
  String Name;
  String Surname;
  String FullName;
  DateTime DateOfBirth;
  String Email;
  String Password;
  String Bio;
  String ProfilePicUrl;

  List<Post> PostsForUser;
  List<Conversation> Conversations;
  //List<Notification> Notifications;
  List<User> Friends;

  User(this.UserID, this.Name, this.Surname, this.DateOfBirth, this.Email,
      this.Password, this.Bio, this.ProfilePicUrl,this.PostsForUser,
      this.Conversations, this.Friends){
    FullName = Name + " " + Surname;
  }
}