import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socialnetworkplatform/BackendHandlers/DbActions.dart';
import 'package:socialnetworkplatform/Models/Conversation.dart';
import 'package:socialnetworkplatform/Models/Friend.dart';
import 'package:socialnetworkplatform/Models/UserSQL.dart';

import '../../Cache.dart';
import '../../Singleton.dart';
import '../MainScreen.dart';
import 'ConversationComponent.dart';

class ProfileScreen extends StatefulWidget {
  UserSQL User;

  ProfileScreen(UserSQL user){
    User = user;
  }

  @override
  State<ProfileScreen> createState() => _ProfileScreenState(User);
}

class _ProfileScreenState extends State<ProfileScreen> {

  UserSQL User;
  bool IsFriend;

  _ProfileScreenState(UserSQL user){
    User = user;
    IsFriend = Cache.Friends.any((x) => (x.UserID == Cache.LoggedUser.UserID && x.FriendUserID == User.UserID) || (x.UserID ==  User.UserID && x.FriendUserID == Cache.LoggedUser.UserID));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blue,
          elevation: 0,
          title: Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                iconSize: 35,
                onPressed: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MaterialApp(
                          home: MainScreen(3)))
                  )
                },
              ),
              Text(
                User.FullName,
              ),
            ],
          )
      ),
      body: SingleChildScrollView(
          child: Column(
            children: [
                  Column(
                  children: [
                  CircleAvatar(
                  radius: 50,
                    backgroundColor: Colors.black,
                    backgroundImage: NetworkImage(
                        User.ProfilePicUrl
                    ),
                  ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Friend friend = new Friend();
                          friend.UserID = Cache.LoggedUser.UserID;
                          friend.FriendUserID = User.UserID;
                          Singleton.socialNetworkRepo.UpdateFriend(
                              IsFriend
                                  ? DbActions.Delete
                                  : DbActions.Add,
                              friend);
                          setState(() {
                            IsFriend = !IsFriend;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                            primary: IsFriend
                                ? Colors.red
                                : Colors.blue,
                            minimumSize: const Size(200,50)
                        ),
                        child: Text(
                          IsFriend
                              ? 'Remove Friend'
                              : 'Add Friend',
                        )
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          bool conversationExists = Cache.Conversations.any((x) => (x.UserIDA == Cache.LoggedUser.UserID && x.UserIDB == User.UserID) || ((x.UserIDA == User.UserID && x.UserIDB == Cache.LoggedUser.UserID)));
                          if(!conversationExists){
                            Conversation conversation = new Conversation();
                            conversation.UserIDA = Cache.LoggedUser.UserID;
                            conversation.UserIDB = User.UserID;
                            conversation.isUnread = true;
                            print(Cache.Conversations.length);
                            await Singleton.socialNetworkRepo.UpdateConversation(DbActions.Add,conversation);
                            print(Cache.Conversations.length);
                          }
                          var conversationToOpen = Cache.Conversations.where((conv) => (conv.UserIDA == User.UserID && conv.UserIDB == Cache.LoggedUser.UserID) || (conv.UserIDB == User.UserID && conv.UserIDA == Cache.LoggedUser.UserID)).toList();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MaterialApp(
                                    home: ConversationComponent(conversationToOpen[0],Cache.Messages.where((mes) => mes.ConversationID == conversationToOpen[0].ConversationID).toList())
                                )
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                            minimumSize: const Size(200,50)
                        ),
                        child: Text(
                            "Send Message"
                        )
                    )
                  ],
                )
                ],
              )
            ],
          )
      ),
    );
  }
}
/*
class ProfileScreen extends StatelessWidget {
  UserSQL User;

  ProfileScreen(UserSQL user){
    User = user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        title: Row(
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back),
              iconSize: 35,
              onPressed: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MaterialApp(
                        home: MainScreen(3)))
                )
              },
            ),
            Text(
              User.FullName,
            ),
          ],
        )
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _ProfileInformation(User),
          ],
        )
      ),
    );
  }
}

class _ProfileInformation extends StatelessWidget {
  UserSQL User;

  bool IsFriend;
  _ProfileInformation(UserSQL user){
    User = user;
    IsFriend = Cache.Friends.any((x) => (x.UserID == Cache.LoggedUser.UserID && x.FriendUserID == User.UserID) || (x.UserID ==  User.UserID && x.FriendUserID == Cache.LoggedUser.UserID));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: Colors.black,
          backgroundImage: NetworkImage(
            User.ProfilePicUrl
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Friend friend = new Friend();
                  friend.UserID = Cache.LoggedUser.UserID;
                  friend.FriendUserID = User.UserID;
                  Singleton.socialNetworkRepo.UpdateFriend(
                      IsFriend
                  ? DbActions.Delete
                  : DbActions.Add,
                  friend);
                },
                style: ElevatedButton.styleFrom(
                  primary: IsFriend
                    ? Colors.red
                    : Colors.blue,
                  minimumSize: const Size(200,50)
                ),
                child: Text(
                    IsFriend
                    ? 'Remove Friend'
                    : 'Add Friend',
                )
            ),
            ElevatedButton(
                onPressed: () {
                  bool conversationExists = Cache.Conversations.any((x) => (x.UserIDA == Cache.LoggedUser.UserID && x.UserIDB == User.UserID) || ((x.UserIDA == User.UserID && x.UserIDB == Cache.LoggedUser.UserID)));
                  if(!conversationExists){
                    Conversation conversation = new Conversation();
                    conversation.UserIDA = Cache.LoggedUser.UserID;
                    conversation.UserIDB = User.UserID;
                    conversation.isUnread = true;
                    Singleton.socialNetworkRepo.UpdateConversation(DbActions.Add,conversation);
                  }

                },
                style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    minimumSize: const Size(200,50)
                ),
                child: Text(
                  "Send Message"
                )
            )
          ],
        )
      ],
    );
  }
}
 */
