import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      // floating: true,
      pinned: true,
      centerTitle: true,
      title: Text("Rotary International"),
      actions: [
        InkWell(
          onTap: () {
            //   Navigator.push(context,
            //       MaterialPageRoute(builder: (context) => NotificationPage(notificationBloc: ,)));
          },
          child: Padding(
              padding: EdgeInsets.only(right: 15),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Icon(Icons.notifications),
                ],
              )),
        )
      ],
    );
  }
}
