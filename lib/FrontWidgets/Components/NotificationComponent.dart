import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Cache.dart';
import '../NotificationData.dart';
class NotificationComponent extends StatelessWidget {
  NotificationData _notificationData;
  NotificationComponent(this._notificationData);

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
                          Cache.Users.where((x) => x.UserID == _notificationData.UserID).elementAt(0).ProfilePicUrl
                      ),
                    ),
                    Container(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 8,
                            right:10,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Flexible(
                                child: RichText(
                                    overflow: TextOverflow.fade,
                                    strutStyle: StrutStyle(fontSize: 12.0),
                                    text: TextSpan(
                                        text: _notificationData.GetNotificationString(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black
                                        )
                                    )

                                ),
                              )
                            ],
                          ),
                        )
                    ),
                  ]

              ),
            )
          ],
        )
    );
  }
}
