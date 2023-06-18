import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialnetworkplatform/Models/Like.dart';
import 'package:socialnetworkplatform/Models/Post.dart';

class PostBloc extends Bloc<PostEvent, PostState>
{
  PostBloc(PostState initialState) : super(initialState){
    on<PostEvent>(_mapEventToState);
  }

  void _mapEventToState(PostEvent event, Emitter<PostState> emit) async {
    var newState = new PostState(event.newPosts, event.newLikes);
    emit(newState);
  }

}

class PostEvent {
  List<Post> newPosts;
  List<Like> newLikes;
  PostEvent(this.newPosts, this.newLikes);
}

class PostState {
  List<Post> Posts;
  List<Like> Likes;
  PostState(this.Posts, this.Likes);
}