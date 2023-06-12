import 'dart:html';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_guid/flutter_guid.dart';
import 'package:socialnetworkplatform/FrontWidgets/Blocs/ConversationsBloc.dart';
import 'package:socialnetworkplatform/Models/Conversation.dart';
import '../Cache.dart';
import '../Models/Post.dart';
import '../Models/UserSQL.dart';
import '../Singleton.dart';
import 'HomeTab.dart';
import 'LoginScreen.dart';
import 'MessageTab.dart';
import 'NotificationsTab.dart';
import 'SearchTab.dart';
class MainScreen extends StatefulWidget {
  int SelectedTab;
  List<Widget> TabViews;
  MainScreen(this.SelectedTab){
    TabViews = [
      HomeTab(
          Cache.Posts
      ),
      MessageTab(
          Cache.Conversations
      ),
      const NotificationsTab(),
      SearchTab(
          Cache.Users
      )
    ];
  }

  @override
  State<MainScreen> createState() => _MainScreenState(SelectedTab,TabViews);
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin{
  int SelectedTab;
  TabController _tabController;
  _MainScreenState(this.SelectedTab,this.TabViews){
    Cache.MainScreenState = this;
    Cache.TabViews = TabViews;
  }
  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        initialIndex: SelectedTab,
        length: 4,
        vsync: this
    );
  }
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  final List<Tab> Tabs = const [
    const Tab(
      text: "Home",
      icon: Icon(Icons.home),
    ),
    const Tab(
      text: "Messages",
      icon: Icon(Icons.messenger_outlined),
    ),
    const Tab(
      text: "Notifications",
      icon: Icon(Icons.notifications_on),
    ),
    const Tab(
      text: "Search Users",
      icon: Icon(Icons.search),
    )
  ];

  List<Widget> TabViews;
  Post newPost = new Post();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => new ConversationBloc(Cache.Conversations),
      child: Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("Social"),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MaterialApp(
                        home: LoginScreen())),
                  );
                },
                icon: const Icon(
                    Icons.logout
                )
            )
          ],
          bottom: TabBar(
              controller: _tabController,
              tabs: Tabs
          ),
        ),
        body: TabBarView(
            controller: _tabController,
            children: TabViews
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MaterialApp(
                    home: Scaffold(
                      body: Column(
                        children: [
                          Text("Add new Post"),
                          Row(
                            children: [
                              Text("Photo"),
                              SizedBox(
                                width: 200,
                                height: 60,
                                child: TextField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Web destination of the photo',
                                    ),
                                    onChanged: (newValue){
                                      newPost.PostPicUrl = newValue;
                                    }
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text("Description"),
                              SizedBox(
                                width: 200,
                                height: 60,
                                child: TextField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Enter your post Description',
                                    ),
                                    onChanged: (newValue){
                                      newPost.Description = newValue;
                                    }
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              TextButton(
                                style: TextButton.styleFrom(
                                  textStyle: Theme.of(context).textTheme.bodyText1,
                                ),
                                child: const Text('Create'),
                                onPressed: () async {
                                  newPost.UserID = Cache.LoggedUser.UserID;
                                  newPost.PostID = Guid.newGuid.toString();
                                  newPost.PostID = await Singleton.socialNetworkRepo.AddPost(newPost);
                                  setState(() {
                                    Cache.Posts.add(newPost);
                                    TabViews = [
                                      HomeTab(
                                          Cache.Posts
                                      ),
                                      MessageTab(
                                          Cache.Conversations
                                      ),
                                      const NotificationsTab(),
                                      SearchTab(
                                          Cache.Users
                                      )
                                    ];
                                  });
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                  textStyle: Theme.of(context).textTheme.bodyText1,
                                ),
                                child: const Text('Discard'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
