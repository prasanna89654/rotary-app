import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rotary/core/resources/app_constants.dart';
import 'package:rotary/core/resources/app_styles.dart';
import 'package:rotary/data/models/news/news_model.dart';
import 'package:rotary/presentation/pages/news/news_details_page.dart';

class AllNewsPage extends StatelessWidget {
  final List<NewsModel> newsList;
  const AllNewsPage({Key? key, required this.newsList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All News'),
      ),
      body: GridView.builder(
        physics: BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        itemCount: newsList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewsDetailsPage(
                    id: newsList[index].id!,
                    newsList: newsList,
                  ),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              // width: 180,
              // height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: AppConstant.DefaultRadius,
                // border: Border.all(
                //   color: AppColors.BorderColor,
                // ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      height: 90,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(
                              newsList[index].imageUrl.toString()),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(8),
                          topLeft: Radius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      newsList[index].title!,
                      style: AppStyles.kB12,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Wrap(
                      // alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: AppConstant.DefaultRadius,
                            color: Color.fromARGB(255, 235, 78, 78),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: AutoSizeText(
                              newsList[index].club ?? "",
                              maxLines: 1,
                              minFontSize: 8,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(newsList[index].getFormattedDate(),
                            textAlign: TextAlign.right, style: AppStyles.kBB12)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
