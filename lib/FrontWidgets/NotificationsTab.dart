import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Components/NotificationComponent.dart';
class NotificationsTab extends StatelessWidget {
  const NotificationsTab();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NotificationComponent(),
        NotificationComponent(),
        NotificationComponent()
      ],
    );
  }
}
