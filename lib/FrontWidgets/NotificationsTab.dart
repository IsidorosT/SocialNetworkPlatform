import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialnetworkplatform/FrontWidgets/Blocs/NotificationBloc.dart';

import '../Cache.dart';
import 'Components/NotificationComponent.dart';
import 'NotificationData.dart';
class NotificationsTab extends StatelessWidget {
  ScrollController _controller;
  NotificationsTab(){
    _controller = new ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationBloc,List<NotificationData>>(
        builder: (context,state) {
          return SingleChildScrollView(
            controller: _controller,
            child: Column(
            children: [
              state.length > 0 ?
              ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                reverse: true,
                itemCount: state.length,
                itemBuilder: (context, index) {
                  var result = state[index];
                  return NotificationComponent(result);
                },
              )
                  :
              Text(
                  "You have no notifications!"
              )
            ],
        ),
          );
        },
    );
  }
}
