import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:socialnetworkplatform/BackendHandlers/WebAPIResponses/LogUserResponse.dart';
import 'package:socialnetworkplatform/Models/Post.dart';
import 'package:socialnetworkplatform/Models/User.dart';

import 'WebAPIResponses/GetPostsForUserResponse.dart';
import 'WebAPIResponses/InsertUserResponse.dart';

class SocialNetworkRepository{

  Map<String,String> _endpointPaths = {
    'LogUser':'/users/logUser',
    'InsertUser':'/users/insertUser',
    'DeleteUser':'/users/deleteUser',
    'GetPostsForUser':'/posts/getPostsForUser'
  };
  String _serviceUrl;
  SocialNetworkRepository(String url){
    _serviceUrl = url;
  }

  Future<LogUserResponse> ValidateUser(String email, String password) async {
    try {
      final queryParams = {
        'email':email,
        'password':password
      };

      var uri = Uri.https(_serviceUrl, _endpointPaths['LogUser'],queryParams);
      print(uri);
      final response = await http.get(uri);
      print(response);
      print(response.body);
      var data = json.decode(response.body);
      var result = new LogUserResponse.fromJson(data);

      return result;
    } catch(e){
      print(e);
      var r = new LogUserResponse();
      r.Success = false;
      return r;
    }
  }

  Future<InsertUserResponse> RegisterUser(UserSQL user) async {
    try{
      var uri = Uri.https(_serviceUrl, _endpointPaths['InsertUser']);
      print(uri);
      //encode Map to JSON
      var body = json.encode(user.toJson(),toEncodable: myEncode);
      final response = await http.post(uri,
          headers: {"Content-Type": "application/json"},
          body: body
      );
      print(response);
      print(response.body);
      var data = json.decode(response.body);
      var result = new InsertUserResponse.fromJson(data);

      return result;
    }
    catch(e){
      var result = new InsertUserResponse(false,"Something went wrong!");
      print(e);
      return result;
    }
  }
  dynamic myEncode(dynamic item) {
    if(item is DateTime) {
      return item.toIso8601String();
    }
    return item;
  }
  Future<GetPostsForUserResponse> GetPostsForUser(String userId) async{
    try {
      final queryParams = {
        'userId':userId,
      };

      var uri = Uri.https(_serviceUrl, _endpointPaths['GetPostsForUser'],queryParams);
      print(uri);
      final response = await http.get(uri);
      print(response);
      print(response.body);
      var data = json.decode(response.body);
      var result = new GetPostsForUserResponse.fromJson(data);

      return result;
    } catch(e){
      print(e);
      var r = new GetPostsForUserResponse(false);
      return r;
    }
  }

}