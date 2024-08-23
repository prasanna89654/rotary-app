import 'package:flutter/material.dart';
import 'package:rotary/core/resources/app_strings.dart';
import 'package:rotary/data/models/business_directory/business_directory.dart';
import 'package:rotary/presentation/pages/directory/directory_detail_page.dart';

class MoreDirectory extends StatelessWidget {
  final List<BusinessDirectory> moreBusinessDirectoriesList;
  const MoreDirectory({Key? key, required this.moreBusinessDirectoriesList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "More Categories",
          style: TextStyle(
            fontSize: 15,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: AppColors.appBackgroundColor,
      body: Container(
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.withOpacity(0.3)),
          borderRadius: BorderRadius.circular(4),
          color: Colors.white,
        ),
        child: ListView.separated(
          itemCount: moreBusinessDirectoriesList.length,
          separatorBuilder: (context, index) => Divider(),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DirectoryDetailPage(
                              directoryTitle:
                                  moreBusinessDirectoriesList[index].name ?? "",
                              directoryUser:
                                  moreBusinessDirectoriesList[index].users ?? [],
                            )));
              },
              child: Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                alignment: Alignment.centerLeft,
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      moreBusinessDirectoriesList[index].name ?? "",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
