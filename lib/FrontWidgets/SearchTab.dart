import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Cache.dart';
import '../Models/UserSQL.dart';
import 'Blocs/UserBloc.dart';
import 'Components/ProfileComponent.dart';

class SearchTab extends StatelessWidget {
  SearchTab();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc,UserState>(
        builder: (context, state) {
          return SearchBar(state.Users);
    });
  }
}

class SearchBar extends StatefulWidget {
  List<UserSQL> Users;
  SearchBar(List<UserSQL> users){
    Users = users;
  }

  @override
  State<SearchBar> createState() => _searchBarState(Users);
}

class _searchBarState extends State<SearchBar> {
  List<UserSQL> Users;
  List<UserSQL> SearchableUsers;
  _searchBarState(List<UserSQL> users){
    Users = users;
  }

  @override
  void initState() {
    super.initState();
    SearchableUsers = Users.where((i) => i.UserID != Cache.LoggedUser.UserID).toList();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc,UserState>(
        builder: (context, state) {
          return  Scaffold(
              appBar: AppBar(
                title: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Search User'
                  ),
                  onChanged: (newText) => {
                    setState(() {
                      SearchableUsers = state.Users.where((i) => i.FullName.contains(newText) && i.UserID != Cache.LoggedUser.UserID).toList();
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
        },
    );
  }
}
