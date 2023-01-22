import 'package:socialnetworkplatform/Models/User.dart';

class LogUserResponse{
  bool Success;
  String ErrorMessage;
  UserSQL LoggedUser;

  LogUserResponse();
  LogUserResponse.fromJson(Map<String, dynamic> json) {
    Success = json['success'];
    ErrorMessage = json['errorMessage'];
    LoggedUser = UserSQL.fromjson(json['loggedUser']);
  }
}