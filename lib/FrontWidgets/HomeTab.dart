import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Models/Post.dart';
import 'Components/PostComponent.dart';

class HomeTab extends StatelessWidget {
  List<Post> Posts;

  HomeTab(List<Post> posts){
    Posts = posts;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: Posts.length,
            itemBuilder: (context, index) {
              var result = Posts[index];
              return PostComponent(result);
            },
          )
        ],
      ),
    );
  }
}
