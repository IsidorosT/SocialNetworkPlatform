import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialnetworkplatform/Models/Friend.dart';
import 'package:socialnetworkplatform/Models/UserSQL.dart';

class UserBloc extends Bloc<UserEvent, UserState>
{
  UserBloc(UserState initialState) : super(initialState){
    on<UserEvent>(_mapEventToState);
  }

  void _mapEventToState(UserEvent event, Emitter<UserState> emit) async {
    var newState = new UserState(event.newUsers, event.newFriends);
    emit(newState);
  }

}

class UserEvent {
  List<UserSQL> newUsers;
  List<Friend> newFriends;
  UserEvent(this.newUsers, this.newFriends);
}

class UserState {
  List<UserSQL> Users;
  List<Friend> Friends;
  UserState(this.Users, this.Friends);
}