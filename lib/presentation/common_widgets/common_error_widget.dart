import 'package:flutter/material.dart';

class CommonErrorWidget extends StatelessWidget {
  final String message;
  const CommonErrorWidget({
    required this.message,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Text(message),
        ),
        SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                // color: Colors.red,
              ),
            ],
          ),
        )
      ],
    );
  }
}
