import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialnetworkplatform/Cache.dart';
import 'package:socialnetworkplatform/Models/Message.dart';

class MessageBloc extends Bloc<MessageEvent, List<Message>>
{
  MessageBloc(List<Message> initialState) : super(initialState){
    on<MessageEvent>(_mapEventToState);
  }

  void _mapEventToState(MessageEvent event, Emitter<List<Message>> emit) async {
    emit(event.newMessages);
  }

}

class MessageEvent {
  List<Message> newMessages;
  MessageEvent(this.newMessages){
  }
}