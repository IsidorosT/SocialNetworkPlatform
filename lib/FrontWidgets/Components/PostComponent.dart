import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socialnetworkplatform/FrontWidgets/Components/PostComponent.dart';
import 'package:socialnetworkplatform/Models/Like.dart';
import 'package:socialnetworkplatform/Models/UserSQL.dart';

import '../../Cache.dart';
import '../../Models/Post.dart';

class PostComponent extends StatefulWidget {
  Post PostDetails;
  PostComponent(Post postDetails){
    PostDetails = postDetails;
  }

  @override
  State<PostComponent> createState() => _PostComponentState(PostDetails);
}

class _PostComponentState extends State<PostComponent> {
  UserSQL UserPost;
  Post PostDetails;
  List<Like> Likes;
  _PostComponentState(Post postDetails){
    PostDetails = postDetails;
    UserPost = Cache.Users.where((element) => element.UserID == PostDetails.UserID).single;
    Likes = Cache.Likes.where((element) => element.PostID == PostDetails.PostID).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                      UserPost.ProfilePicUrl
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
                            UserPost.FullName,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                            )
                        )
                      ],
                    ),
                  )
                ),
                Cache.LoggedUser.UserID == UserPost.UserID ?
                IconButton(
                  onPressed: () {
                    showDialog(
                      useRootNavigator: false,
                      context: context,
                      builder: (context) {
                        return Dialog(
                          child: ListView(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16),
                              shrinkWrap: true,
                              children: [
                                'Delete',
                              ]
                                  .map(
                                    (e) => InkWell(
                                    child: Container(
                                      padding:
                                      const EdgeInsets.symmetric(
                                          vertical: 12,
                                          horizontal: 16),
                                      child: Text(e),
                                    ),
                                    onTap: () {
                                      /*deletePost(
                                        widget.snap['postId']
                                            .toString(),
                                      );

                                       */
                                      // remove the dialog box
                                      Navigator.of(context).pop();
                                    }),
                              )
                                  .toList()),
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.more_vert),
                )
                    : Container()
              ],
            ),
          ),
          //IMAGE Section
          SizedBox(
              height: MediaQuery.of(context).size.height*0.35,
              width: double.infinity,
              child: Image.network(PostDetails.PostPicUrl,
                  fit: BoxFit.cover)

          ),

          //Actions Section
          Row(
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    if(Likes.any((i) => i.UserID == Cache.LoggedUser.UserID)){
                      Likes = Likes.where((i) => i.UserID != Cache.LoggedUser.UserID).toList();
                    }
                    else{
                      var like = new Like();
                      like.UserID = Cache.LoggedUser.UserID;
                      like.PostID = PostDetails.PostID;
                      Likes.add(like);
                    }
                  });
                },
                icon: Likes.any((i) => i.UserID == Cache.LoggedUser.UserID)
                    ? Icon(Icons.favorite,color: Colors.red)
                    : Icon(Icons.favorite_border,color: Colors.grey,)
              ),
              Text(Likes.length.toString())
              //*Comment not for now
              /*
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.comment_outlined)
              ),
              
               */
            ],
          )
        ],
      )
    );
  }
}