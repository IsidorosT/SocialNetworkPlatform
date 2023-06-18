import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialnetworkplatform/Models/Conversation.dart';

import '../../Cache.dart';

class ConversationBloc extends Bloc<ConversationEvent, List<Conversation>>
{
  ConversationBloc(List<Conversation> initialState) : super(initialState){
    on<ConversationEvent>(_mapEventToState);
  }

  void _mapEventToState(ConversationEvent event, Emitter<List<Conversation>> emit) async {
    emit(event.newConversations);
  }

}

class ConversationEvent {
  List<Conversation> newConversations;
  ConversationEvent(this.newConversations){
  }
}