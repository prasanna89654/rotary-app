import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DialogUtils {
  static final DialogUtils _instance = DialogUtils.internal();

  DialogUtils.internal();

  factory DialogUtils() => _instance;

  static void showLoaderDialog(BuildContext context,
      {required bool disableForceClose}) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
            margin: const EdgeInsets.only(left: 7),
            child: const Text(
              'loading...',
              // AppLocalizations.of(context).translate("loading"),
            ),
          ),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static Future<void> showBottomDialog(
      BuildContext buildContext, String title, List<Widget> children,
      {TextStyle? titleTextStyle}) async {
    Widget widgets = SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ListTile(
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(title,
                  textAlign: TextAlign.center,
                  style: titleTextStyle == null
                      ? const TextStyle(
                          color: Colors.black,
                          fontSize: 19,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w600,
                        )
                      : titleTextStyle),
            ),
            onTap: () {
              Navigator.pop(buildContext);
            },
          ),
          const SizedBox(
            height: 16,
          ),
          ListView.builder(
              itemCount: children.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return children[index];
              }),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
    return await showModalBottomSheet(
      context: buildContext,
      backgroundColor: Colors.transparent,
      clipBehavior: Clip.hardEdge,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            color: Colors.white,
          ),
          child: widgets,
        );
      },
    );
  }

  static Future<void> showMailSelectionDialog(
      BuildContext buildContext, String title, Widget children) async {
    return await showModalBottomSheet(
      context: buildContext,
      backgroundColor: Colors.transparent,
      clipBehavior: Clip.hardEdge,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            color: Colors.white,
          ),
          child: children,
        );
      },
    );
  }

  static void showImageSourceDialog(BuildContext context,
      [Function(XFile file)? param1]) {
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 300),
      context: context,
      pageBuilder: (_, __, ___) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                ),
              ),
              height: 120,
              child: Card(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          TextButton(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.camera),
                                Text(
                                  "Camera",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Color.fromRGBO(45, 45, 42, 1),
                                      fontFamily: 'Open Sans',
                                      fontSize: 16,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w600,
                                      height: 1.5),
                                ),
                              ],
                            ),
                            onPressed: () async {
                              final picker = ImagePicker();
                              final a = await picker.pickImage(
                                source: ImageSource.camera,
                                preferredCameraDevice: CameraDevice.rear,
                                imageQuality: 25,
                              );
                              //  final dir =
                              //     await path_provider.getTemporaryDirectory();
                              // ImageCompress imageCompress = ImageCompress();
                              // final targetPath = dir.absolute.path +
                              //     "/${DateTime.now().toIso8601String()}.jpg";
                              // final File b =
                              //     await imageCompress.compress(a, targetPath);
                              if (a != null)
                                Navigator.pop(context, param1?.call(a));
                            },
                          ),
                          TextButton(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.photo_library),
                                Text(
                                  "Gallery",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Color.fromRGBO(45, 45, 42, 1),
                                      fontFamily: 'Open Sans',
                                      fontSize: 16,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w600,
                                      height: 1.5),
                                ),
                              ],
                            ),
                            onPressed: () async {
                              final picker = ImagePicker();
                              final a = await picker.pickImage(
                                source: ImageSource.gallery,
                                imageQuality: 25,
                              );
                              // final dir =
                              //     await path_provider.getTemporaryDirectory();
                              // ImageCompress imageCompress = ImageCompress();
                              // final targetPath = dir.absolute.path +
                              //     "/${DateTime.now().toIso8601String()}.jpg";
                              // final File b =
                              //     await imageCompress.compress(a, targetPath);
                              // if (targetPath != null) {
                              //   Navigator.pop(
                              //     context,
                              //     param1!(
                              //       a!.path,
                              //     ),
                              //   );
                              // }
                              if (a != null) {
                                Navigator.pop(context, await param1?.call(a));
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
    );
  }
}
