import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Cache.dart';
import '../../Models/UserSQL.dart';
import 'ProfileScreen.dart';
class ProfileComponent extends StatelessWidget {

  UserSQL SelectedUser;
  ProfileComponent(UserSQL selectedUser){
    SelectedUser = selectedUser;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MaterialApp(
                  home: ProfileScreen(SelectedUser)
              )
          ),
        );
      },
      child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
            ),
            color: Colors.white,
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 14,
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 16
                ).copyWith(right:0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundImage: NetworkImage(
                          SelectedUser.ProfilePicUrl
                      ),
                    ),
                    Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 8
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  SelectedUser.Name + " " + SelectedUser.Surname,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  )
                              )
                            ],
                          ),
                        )
                    ),
                    Icon(
                        Cache.Friends.any((element) => (element.UserID == Cache.LoggedUser.UserID && element.FriendUserID == SelectedUser.UserID) || (element.UserID == SelectedUser.UserID && element.FriendUserID == Cache.LoggedUser.UserID))
                            ? Icons.person
                            : Icons.add
                    )
                  ],
                ),
              ),
            ],
          )
      ),
    );
  }
}
