import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socialnetworkplatform/Models/Conversation.dart';
import 'package:socialnetworkplatform/Models/Post.dart';
import '../Cache.dart';
import 'RegisterScreen.dart';
import 'MainScreen.dart';
import '../Models/User.dart';
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
                      Text("Social"),
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
                              await GetUserData(response.LoggedUser),
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
  void GetUserData(UserSQL userinfo) async {
    //Cache.LoggedUser = new User()
      //var responsePosts = await Singleton.socialNetworkRepo.GetPostsForUser(userinfo.UserID);
      //var responseFriends = await Singleton.socialNetworkRepo.GetFriendsForUser(Cache.LoggedUser.UserID);
      //var responseFriends = await Singleton.socialNetworkRepo.GetNotificationsForUser(Cache.LoggedUser.UserID);
  }
}


