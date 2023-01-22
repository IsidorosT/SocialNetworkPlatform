import 'dart:html';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socialnetworkplatform/Models/Conversation.dart';
import '../Models/Post.dart';
import '../Models/User.dart';
import 'HomeTab.dart';
import 'LoginScreen.dart';
import 'MessageTab.dart';
import 'NotificationsTab.dart';
import 'SearchTab.dart';
class MainScreen extends StatefulWidget {
  int SelectedTab;
  MainScreen(this.SelectedTab);

  @override
  State<MainScreen> createState() => _MainScreenState(SelectedTab);
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin{
  int SelectedTab;
  TabController _tabController;
  _MainScreenState(this.SelectedTab);
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

  final List<Widget> TabViews = [
    HomeTab(
        [
          new Post(
              UserPost: new UserSQL("1","Ilias","Tsarouxas", new DateTime(1),"t","sss","dsfsfd", "https://i0.wp.com/newspack-washingtoncitypaper.s3.amazonaws.com/uploads/2009/04/contexts.org_socimages_files_2009_04_d_silhouette.png?fit=1200%2C756&ssl=1"),
              PostPicUrl: "https://cdn.pixabay.com/photo/2012/08/27/14/19/mountains-55067__340.png",
              Liked: [new UserSQL("2", "Prokopis","Papadopoulos",new DateTime(1),"t","sss","dsfsfd", "https://i0.wp.com/newspack-washingtoncitypaper.s3.amazonaws.com/uploads/2009/04/contexts.org_socimages_files_2009_04_d_silhouette.png?fit=1200%2C756&ssl=1"),
                new UserSQL("3", "Ernesto", "Valverde",new DateTime(1),"t","sss","dsfsfd", "https://i0.wp.com/newspack-washingtoncitypaper.s3.amazonaws.com/uploads/2009/04/contexts.org_socimages_files_2009_04_d_silhouette.png?fit=1200%2C756&ssl=1")]
          ),
          new Post(
              UserPost: new UserSQL("3", "Ernesto", "Valverde",new DateTime(1),"t","sss","dsfsfd","https://i0.wp.com/newspack-washingtoncitypaper.s3.amazonaws.com/uploads/2009/04/contexts.org_socimages_files_2009_04_d_silhouette.png?fit=1200%2C756&ssl=1"),
              PostPicUrl: "https://cdn.pixabay.com/photo/2018/08/14/13/23/ocean-3605547__480.jpg",
              Liked: [new UserSQL("2", "Prokopis", "Papadopoulos",new DateTime(1),"t","sss","dsfsfd","https://i0.wp.com/newspack-washingtoncitypaper.s3.amazonaws.com/uploads/2009/04/contexts.org_socimages_files_2009_04_d_silhouette.png?fit=1200%2C756&ssl=1"),
                new UserSQL("1","Ilias", "Tsarouxas",new DateTime(1),"t","sss","dsfsfd","https://i0.wp.com/newspack-washingtoncitypaper.s3.amazonaws.com/uploads/2009/04/contexts.org_socimages_files_2009_04_d_silhouette.png?fit=1200%2C756&ssl=1")]
          ),
          new Post(
              UserPost: new UserSQL("4", "Orestis","Asimakopoulos", new DateTime(1),"t","sss","dsfsfd", "https://i0.wp.com/newspack-washingtoncitypaper.s3.amazonaws.com/uploads/2009/04/contexts.org_socimages_files_2009_04_d_silhouette.png?fit=1200%2C756&ssl=1"),
              PostPicUrl: "https://images.unsplash.com/photo-1491466424936-e304919aada7?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8M3x8fGVufDB8fHx8&w=1000&q=80",
              Liked: []
            )
        ]
    ),
    MessageTab([
      new Conversation(
          ConversationID: "1",
          LastMessage: "Hey bro",
          isUnread : true,
          RecipientUser: new UserSQL("3", "Ernesto", "Valverde", new DateTime(1),"t","sss","dsfsfd","https://i0.wp.com/newspack-washingtoncitypaper.s3.amazonaws.com/uploads/2009/04/contexts.org_socimages_files_2009_04_d_silhouette.png?fit=1200%2C756&ssl=1")
      ),
      new Conversation(
          ConversationID: "2",
          LastMessage: "MANNNSD SJDEWJHFKSDHFKJH DSKJFHKDSJHFKJDSHFKJSDFHJKSSDJFHKJSDHFKSDHFJKHSDFKJSDHFK",
          isUnread : false,
          RecipientUser: new UserSQL("4", "Orestis", "Asimakopoulos", new DateTime(1),"t","sss","dsfsfd","https://i0.wp.com/newspack-washingtoncitypaper.s3.amazonaws.com/uploads/2009/04/contexts.org_socimages_files_2009_04_d_silhouette.png?fit=1200%2C756&ssl=1")
      ),
    ]),
    const NotificationsTab(),
    SearchTab([
      new UserSQL("2", "Prokopis", "Papadopoulos", new DateTime(1),"t","sss","dsfsfd","https://i0.wp.com/newspack-washingtoncitypaper.s3.amazonaws.com/uploads/2009/04/contexts.org_socimages_files_2009_04_d_silhouette.png?fit=1200%2C756&ssl=1"),
      new UserSQL("3", "Ernesto", "Valverde", new DateTime(1),"t","sss","dsfsfd","https://i0.wp.com/newspack-washingtoncitypaper.s3.amazonaws.com/uploads/2009/04/contexts.org_socimages_files_2009_04_d_silhouette.png?fit=1200%2C756&ssl=1"),
      new UserSQL("4", "Orestis", "Asimakopoulos", new DateTime(1),"t","sss","dsfsfd","https://i0.wp.com/newspack-washingtoncitypaper.s3.amazonaws.com/uploads/2009/04/contexts.org_socimages_files_2009_04_d_silhouette.png?fit=1200%2C756&ssl=1")
    ])
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        )
    );
  }
}
