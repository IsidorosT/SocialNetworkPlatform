import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socialnetworkplatform/BackendHandlers/IncrementalDataProvider.dart';
import 'package:socialnetworkplatform/FrontWidgets/Blocs/UserBloc.dart';
import 'package:socialnetworkplatform/Models/Conversation.dart';
import 'package:socialnetworkplatform/Models/Post.dart';
import '../Cache.dart';
import 'Blocs/ConversationsBloc.dart';
import 'Blocs/MessageBloc.dart';
import 'Blocs/NotificationBloc.dart';
import 'Blocs/PostBloc.dart';
import 'NotificationData.dart';
import 'RegisterScreen.dart';
import 'MainScreen.dart';
import '../Models/UserSQL.dart';
import '../Singleton.dart';
import '../BackendHandlers/WebAPIResponses/LogUserResponse.dart';

class LoginScreen extends StatelessWidget {
  String email = "";
  String password = "";
  LogUserResponse response;
  LoginScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Connect", style: Theme.of(context).textTheme.headline1),
                    ],
                  ),
                  SizedBox(
                    //Use of SizedBox
                    height: 150,
                  ),
                  Container(
                    constraints: BoxConstraints.loose(Size.square(500)),
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(color: Colors.black),
                        left: BorderSide(color: Colors.black),
                        right: BorderSide(),
                        bottom: BorderSide(),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Login",
                              style: TextStyle(
                                fontSize: 40
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          //Use of SizedBox
                          height: 100,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 200,
                              height: 60,
                              child: TextField(
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Email',
                                    hintText: 'Enter Your Email'
                                ),
                                onChanged: (newValue) => {
                                  email = newValue
                                },
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          //Use of SizedBox
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 200,
                              height: 60,
                              child: TextField(
                                obscureText: true,
                                enableSuggestions: false,
                                autocorrect: false,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Password',
                                    hintText: 'Enter Your Password'
                                ),
                                onChanged: (newValue) => {
                                  password = newValue
                                },
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          //Use of SizedBox
                          height: 10,
                        ),
                        FloatingActionButton.extended(
                          label: Text("Login"),
                          icon: Icon(Icons.login),
                          focusColor: Colors.grey,
                          onPressed: () async =>  {
                            response = await Singleton.socialNetworkRepo.ValidateUser(email, password),
                            if(response.Success){
                              Cache.LoggedUser = response.LoggedUser,
                              Cache.Session = response.Session,
                              print(Cache.Session + "_" + Cache.LoggedUser.UserID),
                              await GetUserData(),
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => MaterialApp(
                                home: MainScreen(0)))
                              ),
                            }
                            else{
                                showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                    title: const Text("Error"),
                                    content: const Text("Wrong Credentials"),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () => Navigator.pop(ctx, 'OK'),
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  )
                                )
                            }

                          },
                        ),
                        SizedBox(
                          //Use of SizedBox
                          height: 10,
                        ),
                        InkWell(
                            child: new Text(
                                'Create a new account',
                            ),
                            highlightColor: Colors.red,
                            hoverColor: Colors.blue,
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => MaterialApp(
                                  home: RegisterScreen())),
                            )
                        )

                      ],
                    )
                  )
                ],
              ),
            )
        );
  }
  Future GetUserData() async {
      var response = await Singleton.socialNetworkRepo.GetDataForUser(Cache.Session,Cache.LoggedUser.UserID,true,true,true,true,true,true);
      print(Cache);
      Cache.Users = response.Users;
      Cache.Posts = response.Posts;
      Cache.Friends = response.Friends;
      Cache.Likes = response.Likes;
      Cache.Conversations = response.Conversations;
      Cache.Messages = response.Messages;
      Cache.Notifications = [];
      Cache.conversationBloc = new ConversationBloc(response.Conversations);
      Cache.messageBloc = new MessageBloc(response.Messages);
      Cache.userBloc = new UserBloc(new UserState(response.Users, response.Friends));
      Cache.postBloc = new PostBloc(new PostState(response.Posts,response.Likes));
      Cache.notificationBloc = new NotificationBloc([]);
      print("Initializing Updater...");
      IncrementalDataProvider.InitializeUpdater();
  }
}


