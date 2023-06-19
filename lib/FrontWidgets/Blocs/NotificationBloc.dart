import 'package:flutter_bloc/flutter_bloc.dart';

import '../NotificationData.dart';

class NotificationBloc extends Bloc<NotificationEvent, List<NotificationData>>
{
  NotificationBloc(List<NotificationData> initialState) : super(initialState){
    on<NotificationEvent>(_mapEventToState);
  }

  void _mapEventToState(NotificationEvent event, Emitter<List<NotificationData>> emit) async {
    emit(event.newNotifications);
  }

}

class NotificationEvent {
  List<NotificationData> newNotifications;
  NotificationEvent(this.newNotifications){
  }
}