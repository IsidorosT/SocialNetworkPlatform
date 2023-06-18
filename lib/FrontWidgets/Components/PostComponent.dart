import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socialnetworkplatform/FrontWidgets/Blocs/PostBloc.dart';
import 'package:socialnetworkplatform/FrontWidgets/Components/PostComponent.dart';
import 'package:socialnetworkplatform/Models/Like.dart';
import 'package:socialnetworkplatform/Models/UserSQL.dart';

import '../../Cache.dart';
import '../../Models/Post.dart';
import '../../Singleton.dart';
import '../HomeTab.dart';
import '../MessageTab.dart';
import '../NotificationsTab.dart';
import '../SearchTab.dart';

class PostComponent extends StatelessWidget {
  Post PostDetails;
  UserSQL UserPost;
  List<Like> Likes;
  PostComponent(Post postDetails){
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
                    onPressed: () async{
                      await showDialog(
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
                                      onTap: () async {
                                        Cache.Posts.remove(PostDetails);
                                        await Singleton.socialNetworkRepo.DeletePost(PostDetails);

                                        Cache.MainScreenState.setState(() {
                                          Cache.MainScreenState.widget.TabViews[0] = HomeTab(
                                              Cache.Posts
                                          );
                                        });
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
                        var like = new Like();
                        like.UserID = Cache.LoggedUser.UserID;
                        like.PostID = PostDetails.PostID;
                        if(Likes.any((i) => i.UserID == Cache.LoggedUser.UserID)){
                          Singleton.socialNetworkRepo.RemoveLike(like);
                          Likes = Likes.where((i) => i.UserID != Cache.LoggedUser.UserID).toList();
                          Cache.Likes = Cache.Likes.where((x) => x.UserID != like.UserID && x.PostID != like.PostID);
                        }
                        else{
                          Singleton.socialNetworkRepo.AddLike(like);
                          Likes.add(like);
                          Cache.Likes.add(like);
                        }
                        Cache.postBloc.add(new PostEvent(Cache.Posts,Cache.Likes));
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
            ),
            Row(
                children: [
                  Text(PostDetails.Description)
                ]
            )
          ],
        )
    );
  }
}

/*
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
                  onPressed: () async{
                    await showDialog(
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
                                    onTap: () async {
                                      Cache.Posts.remove(PostDetails);
                                      await Singleton.socialNetworkRepo.DeletePost(PostDetails);

                                      Cache.MainScreenState.setState(() {
                                        Cache.MainScreenState.widget.TabViews[0] = HomeTab(
                                              Cache.Posts
                                          );
                                      });
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
                    var like = new Like();
                    like.UserID = Cache.LoggedUser.UserID;
                    like.PostID = PostDetails.PostID;
                    if(Likes.any((i) => i.UserID == Cache.LoggedUser.UserID)){
                      Singleton.socialNetworkRepo.RemoveLike(like);
                      Likes = Likes.where((i) => i.UserID != Cache.LoggedUser.UserID).toList();
                    }
                    else{
                      Singleton.socialNetworkRepo.AddLike(like);
                      Likes.add(like);

                    }
                  });
                },
                icon: Likes.any((i) => i.UserID == Cache.LoggedUser.UserID)
                    ? Icon(Icons.favorite,color: Colors.red)
                    : Icon(Icons.favorite_border,color: Colors.grey,)
              ),
              Text(Likes.length.toString())
              //Comment not for now
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.comment_outlined)
              ),
              

            ],
          ),
          Row(
              children: [
                Text(PostDetails.Description)
              ]
          )
        ],
      )
    );
  }
}

 */