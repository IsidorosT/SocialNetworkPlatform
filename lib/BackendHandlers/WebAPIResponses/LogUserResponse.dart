import 'package:socialnetworkplatform/Models/UserSQL.dart';

class LogUserResponse{
  bool Success;
  String ErrorMessage;
  UserSQL LoggedUser;
  String Session;

  LogUserResponse();
  LogUserResponse.fromJson(Map<String, dynamic> json) {
    Success = json['success'];
    ErrorMessage = json['errorMessage'];
    LoggedUser = UserSQL.fromJson(json['loggedUser']);
    Session = json['session'];
  }
}