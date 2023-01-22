import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class NotificationComponent extends StatelessWidget {
  const NotificationComponent();

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
                          "https://i0.wp.com/newspack-washingtoncitypaper.s3.amazonaws.com/uploads/2009/04/contexts.org_socimages_files_2009_04_d_silhouette.png?fit=1200%2C756&ssl=1"
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
                                        text: "last message",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
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
