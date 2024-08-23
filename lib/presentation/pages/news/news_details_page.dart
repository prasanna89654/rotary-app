import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rotary/core/resources/app_constants.dart';
import 'package:rotary/core/resources/app_strings.dart';
import 'package:rotary/core/resources/app_styles.dart';
import 'package:rotary/core/utils/com_fun.dart';
import 'package:rotary/data/models/news/news_details_model.dart';
import 'package:rotary/data/models/news/news_model.dart';
import 'package:rotary/presentation/features/news_bloc/news_bloc.dart';

class NewsDetailsPage extends StatefulWidget {
  final String id;
  final List<NewsModel> newsList;

  const NewsDetailsPage({Key? key, required this.id, required this.newsList})
      : super(key: key);

  @override
  State<NewsDetailsPage> createState() => _NewsDetailsPageState();
}

class _NewsDetailsPageState extends State<NewsDetailsPage> {
  @override
  void initState() {
    super.initState();
    // newsList = widget.newsList;
    //  newsModel = newsList.here((element) => element.id == widget.id);
    // newsList.removeWhere((element) => element.id == widget.id);

    BlocProvider.of<NewsBloc>(context).add(LoadNewsDetailsEvent(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News Details'),
      ),
      body: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          if (state is NewsDetailsLoaded) {
            return _buildNewsDetails(state.newsdetails);
          } else if (state is NewsLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is NewsError) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  _buildNewsDetails(NewsDetailsModel newsDetailsModel) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          Container(
            alignment: Alignment.bottomLeft,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.rotaryGold,
            ),
            child: Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Container(
                  child: CachedNetworkImage(
                    imageUrl: newsDetailsModel.imageUrl ?? "",
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 3),
                        decoration: BoxDecoration(
                            color: AppColors.rotaryBlue,
                            borderRadius: BorderRadius.circular(5)),
                        child: Text(
                          newsDetailsModel.club ?? "",
                          style: AppStyles.kWB14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  newsDetailsModel.title ?? "",
                  style: AppStyles.kBB12,
                ),
                SizedBox(height: 8),
                Text(
                  getFormattedDate(newsDetailsModel.publishDate!),
                  style: AppStyles.kB12,
                ),
                SizedBox(height: 8),
                Text(
                  newsDetailsModel.description ?? "",
                  style: AppStyles.kB12,
                ),
                SizedBox(height: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 8,
                        right: 20,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("More News", style: AppStyles.kBB14),
                          // GestureDetector(
                          //   onTap: () {
                          //     Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //         builder: (context) => AllNewsPage(
                          //           newsList: widget.newsList,
                          //         ),
                          //       ),
                          //     );
                          //   },
                          //   child: Container(
                          //     width: 30,
                          //     height: 30,
                          //     decoration: BoxDecoration(
                          //       color: AppColors.rotaryBlue,
                          //       shape: BoxShape.circle,
                          //     ),
                          //     child: Icon(
                          //       Icons.arrow_forward_ios,
                          //       color: Colors.white,
                          //       size: 15,
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 260,
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.newsList.length > 3
                            ? 3
                            : widget.newsList.length,
                        itemBuilder: (context, index) {
                          int indexOfItemTobeRemoved = widget.newsList
                              .indexWhere((element) => element.id == widget.id);
                          return InkWell(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NewsDetailsPage(
                                        id: widget.newsList[index].id!,
                                        newsList: widget.newsList)),
                              );
                            },
                            child: index == indexOfItemTobeRemoved
                                ? Container()
                                : Container(
                                    margin: const EdgeInsets.only(right: 8),
                                    width: 190,
                                    // height: 100,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: AppConstant.DefaultRadius,
                                      // border: Border.all(
                                      //   color: AppColors.BorderColor,
                                      // ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          clipBehavior: Clip.antiAlias,
                                          height: 150,
                                          decoration: BoxDecoration(
                                            color: Colors.grey,
                                            image: DecorationImage(
                                              image: CachedNetworkImageProvider(
                                                  widget
                                                      .newsList[index].imageUrl
                                                      .toString()),
                                              fit: BoxFit.cover,
                                            ),
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(8),
                                              topLeft: Radius.circular(8),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            widget.newsList[index].title!,
                                            style: AppStyles.kB12,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Wrap(
                                            crossAxisAlignment:
                                                WrapCrossAlignment.center,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      AppConstant.DefaultRadius,
                                                  color: Color.fromARGB(
                                                      255, 235, 78, 78),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 10,
                                                      vertical: 5),
                                                  child: AutoSizeText(
                                                    widget
                                                        .newsList[index].club!,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    minFontSize: 8,
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              AutoSizeText(
                                                widget.newsList[index]
                                                    .getFormattedDate(),
                                                textAlign: TextAlign.right,
                                                style: AppStyles.kBB12,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              )
                                            ],
                                          ),
                                        )
                                        // Padding(
                                        //   padding: const EdgeInsets.all(8.0),
                                        //   child: Row(
                                        //     // crossAxisAlignment: CrossAxisAlignment.center,
                                        //     children: [
                                        //       Container(
                                        //         decoration: BoxDecoration(
                                        //           borderRadius:
                                        //               AppConstant.DefaultRadius,
                                        //           color: Color.fromARGB(
                                        //               255, 235, 78, 78),
                                        //         ),
                                        //         child: Padding(
                                        //           padding: const EdgeInsets
                                        //                   .symmetric(
                                        //               horizontal: 10,
                                        //               vertical: 5),
                                        //           child: Text(
                                        //             widget
                                        //                 .newsList[index].club!,
                                        //             style: TextStyle(
                                        //                 fontSize: 12,
                                        //                 fontWeight:
                                        //                     FontWeight.bold,
                                        //                 color: Colors.white),
                                        //           ),
                                        //         ),
                                        //       ),
                                        //       SizedBox(
                                        //         width: 5,
                                        //       ),
                                        //       Expanded(
                                        //         child: Text(
                                        //           widget.newsList[index]
                                        //               .getFormattedDate(),
                                        //           textAlign: TextAlign.right,
                                        //           style: AppStyles.kBB12,
                                        //         ),
                                        //       )
                                        //     ],
                                        //   ),
                                        // )
                                      ],
                                    ),
                                  ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
