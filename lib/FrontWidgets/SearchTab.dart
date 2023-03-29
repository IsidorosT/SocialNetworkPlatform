import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Models/UserSQL.dart';
import 'Components/ProfileComponent.dart';

class SearchTab extends StatefulWidget {
  List<UserSQL> Users;
  SearchTab(List<UserSQL> users){
    Users = users;
  }

  @override
  State<SearchTab> createState() => _searchTabState(Users);
}

class _searchTabState extends State<SearchTab> {
  List<UserSQL> Users;
  List<UserSQL> SearchableUsers;
  _searchTabState(List<UserSQL> users){
    Users = users;
  }

  @override
  void initState() {
    super.initState();
    SearchableUsers = Users;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Search User'
              ),
              onChanged: (newText) => {
                setState(() {
                  SearchableUsers = Users.where((i) => i.FullName.contains(newText)).toList();
                })
                },
            ),
      ),
        body: ListView.builder(
          itemCount: SearchableUsers.length,
          itemBuilder: (context, index) {
            var result = SearchableUsers[index];
            return ProfileComponent(result);
          },
        )
      );
  }
}
