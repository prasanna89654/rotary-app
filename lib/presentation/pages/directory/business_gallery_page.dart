import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rotary/presentation/common_widgets/common_dialog.dart';

class BusinessGalleryPage extends StatelessWidget {
  final List<String> businessGallery;
  final List<String> remBusinessGallery = [];
  BusinessGalleryPage({Key? key, required this.businessGallery})
      : super(key: key) {
    remBusinessGallery.addAll(businessGallery);
    remBusinessGallery.removeAt(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Row(
            children: [
              SizedBox(width: 5),
              Icon(
                Icons.arrow_back_ios_new_sharp,
                size: 15,
                color: Colors.black,
              ),
              SizedBox(width: 5),
              Text(
                "Back",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
            ],
          ),
        ),
        title: Text(
          "Photos Gallery",
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                showCommonDialog(context, businessGallery[0]);
              },
              child: Container(
                height: 220,
                width: double.infinity,
                child: CachedNetworkImage(
                  imageUrl: businessGallery[0],
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            GridView.builder(
                shrinkWrap: true,
                itemCount: remBusinessGallery.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio:
                        (MediaQuery.of(context).size.width / 2) / 135),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      showCommonDialog(context, remBusinessGallery[index]);
                    },
                    child: Container(
                      child: CachedNetworkImage(
                        imageUrl: remBusinessGallery[index],
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
