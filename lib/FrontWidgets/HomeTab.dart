import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialnetworkplatform/FrontWidgets/Blocs/PostBloc.dart';
import '../Models/Post.dart';
import 'Components/PostComponent.dart';

class HomeTab extends StatelessWidget {
  List<Post> Posts;

  HomeTab(List<Post> posts){
    Posts = posts;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc,PostState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: state.Posts.length,
                  itemBuilder: (context, index) {
                    var result = state.Posts[index];
                    return PostComponent(result);
                  },
                )
              ],
            ),
          );
        }
    );
  }
}
