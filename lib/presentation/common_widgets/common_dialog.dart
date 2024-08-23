import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Future<void> showCommonDialog(context, String filePath) {
  return showGeneralDialog(
    barrierDismissible: true,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    context: context,
    pageBuilder: (_, __, ___) {
      return CommonDialog(filePath: filePath);
    },
  );
}

class CommonDialog extends StatefulWidget {
  final String filePath;
  const CommonDialog({
    Key? key,
    required this.filePath,
  }) : super(key: key);

  @override
  State<CommonDialog> createState() => _CommonDialogState();
}

class _CommonDialogState extends State<CommonDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  void closeDialog() {
    _controller.reverse().then((value) => Navigator.pop(context));
  }

  @override
  void initState() {
    super.initState();
    // player.play("Coin-collect-sound-effect.mp3");
    _controller = AnimationController(
      duration: const Duration(
        milliseconds: 200,
      ),
      vsync: this,
    );

    _animation = CurveTween(curve: Curves.easeIn).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
        child: Center(
          child: Container(
            // margin: const EdgeInsets.all(20),
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Material(
                      borderRadius: BorderRadius.circular(20),
                      child: IconButton(
                        onPressed: () {
                          // Navigator.of(context).pop();
                          closeDialog();
                        },
                        icon: Icon(Icons.close),
                      ),
                    ),
                  ),
                  Expanded(
                    child: DefaultTextStyle(
                      style: TextStyle(color: Colors.black),
                      child: InteractiveViewer(
                        panEnabled: true, // Set it to false
                        // boundaryMargin: EdgeInsets.all(100),
                        minScale: 1,
                        maxScale: 5,
                        child: CachedNetworkImage(
                          imageUrl: widget.filePath,
                          placeholder: (context, url) =>
                              Center(child: CircularProgressIndicator()),
                          height: double.infinity,
                          width: double.infinity,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
