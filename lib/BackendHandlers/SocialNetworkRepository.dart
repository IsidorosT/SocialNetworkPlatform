import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:socialnetworkplatform/BackendHandlers/DbActions.dart';
import 'package:socialnetworkplatform/BackendHandlers/WebAPIRequest/Credentials.dart';
import 'package:socialnetworkplatform/BackendHandlers/WebAPIRequest/MemoryRequest.dart';
import 'package:socialnetworkplatform/BackendHandlers/WebAPIResponses/LogUserResponse.dart';
import 'package:socialnetworkplatform/BackendHandlers/WebAPIResponses/MemoryResponse.dart';
import 'package:socialnetworkplatform/Models/Conversation.dart';
import 'package:socialnetworkplatform/Models/Friend.dart';
import 'package:socialnetworkplatform/Models/Like.dart';
import 'package:socialnetworkplatform/Models/Message.dart';
import 'package:socialnetworkplatform/Models/Post.dart';
import 'package:socialnetworkplatform/Models/UserSQL.dart';

import '../Cache.dart';
import 'WebAPIResponses/GetPostsForUserResponse.dart';
import 'WebAPIResponses/InsertUserResponse.dart';

class SocialNetworkRepository{

  Map<String,String> _endpointPaths = {
    'GetUsers':'/users/all',
    'LogUser':'/users/logUser',
    'InsertUser':'/users/insertUser',
    'DeleteUser':'/users/deleteUser',
    'GetData':'/memory/getData',
    'AddLike':'/likes/add',
    'RemoveLike':'/likes/delete',
    'AddPost':'/posts/add',
    'DeletePost':'/posts/delete',
    'GetUpdates':'/memory/getUpdates',
    'AddFriend':'/friends/add',
    'RemoveFriend':'/friends/delete',
    'AddConversation':'/conversations/add',
    'RemoveConversation':'/conversations/delete',
    'AddMessage':'/messages/add',
    'ReadConversation': '/conversations/read'
  };
  String _serviceUrl;
  SocialNetworkRepository(String url){
    _serviceUrl = url;
  }

  Future<List<UserSQL>> GetUsers() async{
    try{
      var uri = Uri.https(_serviceUrl, _endpointPaths['GetUsers']);
      print(uri);
      final response = await http.get(uri);
      print(response);
      print(response.body);
      var data = json.decode(response.body);
      var result = new LogUserResponse.fromJson(data);

      return null;
    }catch(e){

    }
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
  Future<MemoryResponse> GetDataForUser(
      String session,
      String userID,
      bool includeUsers,
      bool includePosts,
      bool includeLikes,
      bool includeFriends,
      bool includeMessages,
      bool includeConversations) async{
    try {
      var request = new MemoryRequest(
          includeUsers,
          includePosts,
          includeLikes,
          includeFriends,
          includeMessages,
          includeConversations,
          session,
          userID);

      var uri = Uri.https(_serviceUrl, _endpointPaths['GetData']);
      print(uri);
      var body = json.encode(request.toJson(),toEncodable: myEncode);
      final response = await http.post(uri,
          headers: {"Content-Type": "application/json"},
          body: body
      );
      var data = json.decode(response.body);
      var result = new MemoryResponse.fromJson(data);

      return result;
    } catch(e){
      print(e);
      var r = new MemoryResponse(Success: false);
      return r;
    }
  }

  Future<bool> AddLike(Like like) async{

      var uri = Uri.https(_serviceUrl, _endpointPaths['AddLike']);
      print(uri);
      //encode Map to JSON
      var body = json.encode(like.toJson(),toEncodable: myEncode);
      final response = await http.post(uri,
          headers: {"Content-Type": "application/json"},
          body: body
      );
      print(response);
      print(response.body);
      var data = json.decode(response.body);
      var result = data;

      return result;
  }

  Future<bool> RemoveLike(Like like) async{
      var uri = Uri.https(_serviceUrl, _endpointPaths['RemoveLike']);
      print(uri);
      //encode Map to JSON
      var body = json.encode(like.toJson(),toEncodable: myEncode);
      final response = await http.delete(uri,
          headers: {"Content-Type": "application/json"},
          body: body
      );
      print(response);
      print(response.body);
      var data = json.decode(response.body);
      var result = data;

      return result;
  }

  Future<String> AddPost(Post post) async{

    var uri = Uri.https(_serviceUrl, _endpointPaths['AddPost']);
    print(uri);
    //encode Map to JSON
    var body = json.encode(post.toJson(),toEncodable: myEncode);
    final response = await http.post(uri,
        headers: {"Content-Type": "application/json"},
        body: body
    );
    print(response);
    print(response.body);
    var data = response.body;
    var result = data;

    return result;
  }

  Future<bool> DeletePost(Post post) async{

    var uri = Uri.https(_serviceUrl, _endpointPaths['DeletePost']);
    print(uri);
    //encode Map to JSON
    var body = json.encode(post.toJson(),toEncodable: myEncode);
    final response = await http.delete(uri,
        headers: {"Content-Type": "application/json"},
        body: body
    );
    print(response);
    print(response.body);
    var data = json.decode(response.body);
    var result = data;

    return result;
  }

  Future<MemoryResponse> GetUpdates() async{
    try {
      var request = new Credentials(
          Cache.Session,
          Cache.LoggedUser.UserID);

      var uri = Uri.https(_serviceUrl, _endpointPaths['GetUpdates']);
      var body = json.encode(request.toJson(),toEncodable: myEncode);
      final response = await http.post(uri,
          headers: {"Content-Type": "application/json"},
          body: body
      );

      var data = json.decode(response.body);
      var result = new MemoryResponse.fromJson(data);

      return result;
    } catch(e){
      print(e);
      var r = new MemoryResponse(Success: false);
      return r;
    }
  }

  Future<bool> UpdateFriend(DbActions action, Friend friend) async {
    String endpoint = action == DbActions.Add
        ? _endpointPaths['AddFriend']
        : _endpointPaths['RemoveFriend'];
    var uri = Uri.https(_serviceUrl, endpoint);
    print(uri);
    //encode Map to JSON
    var body = json.encode(friend.toJson(),toEncodable: myEncode);
    final response = action == DbActions.Add
        ? await http.post(uri,
          headers: {"Content-Type": "application/json"},
          body: body
        )
        : await http.delete(uri,
            headers: {"Content-Type": "application/json"},
            body: body
        );
    print(response);
    print(response.body);
    if(action == DbActions.Add){
      Cache.Friends.add(friend);
    }
    else{
      Cache.Friends = Cache.Friends.where((element) => !((element.UserID == friend.UserID && element.FriendUserID == friend.FriendUserID)||(element.UserID == friend.FriendUserID && element.FriendUserID == friend.UserID))).toList();
    }
    var data = json.decode(response.body);
    var result = data;

    return result;
  }

  Future<bool> UpdateConversation(DbActions action, Conversation conversation) async {
    String endpoint = action == DbActions.Add
        ? _endpointPaths['AddConversation']
        : _endpointPaths['RemoveConversation'];
    var uri = Uri.https(_serviceUrl, endpoint);
    print(uri);
    //encode Map to JSON
    var body = json.encode(conversation.toJson(includeID: false),toEncodable: myEncode);
    final response = await http.post(uri,
        headers: {"Content-Type": "application/json"},
        body: body
    );
    print(response);
    print(response.body);
    if(action == DbActions.Add){
      if(response.body == ""){
        return false;
      }
      conversation.ConversationID = response.body;
      Cache.Conversations.add(conversation);
      print(Cache.Conversations.length);
      return true;
    }
    else{
      Cache.Conversations.remove(conversation);
    }
    var data = json.decode(response.body);
    var result = data;

    return result;
  }

  Future<bool> AddMessage(String conversationId, String messageContent) async {
    String endpoint = _endpointPaths['AddMessage'];
    var uri = Uri.https(_serviceUrl, endpoint);
    print(uri);
    var message = new Message(MessageID: conversationId, ConversationID: conversationId, Sender: Cache.LoggedUser.UserID, MessageContent: messageContent, SendDate: DateTime.now());
    //encode Map to JSON
    var body = json.encode(message.toJson(),toEncodable: myEncode);
    final response = await http.post(uri,
        headers: {"Content-Type": "application/json"},
        body: body
    );
    print(response);
    print(response.body);
    var result = json.decode(response.body);

    return result;
  }

  Future<bool> ReadConversation(String conversationId) async {
    String endpoint = _endpointPaths['ReadConversation'];
    var uri = Uri.https(_serviceUrl, endpoint);
    print(uri);
    //encode Map to JSON
    var body = json.encode(conversationId,toEncodable: myEncode);
    final response = await http.patch(uri,
        headers: {"Content-Type": "application/json"},
        body: body
    );
    print(response);
    print(response.body);
    var result = json.decode(response.body);

    return result;
  }
}