import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rotary/core/resources/app_strings.dart';
import 'package:rotary/core/resources/app_styles.dart';
import 'package:rotary/data/models/business_directory/business_directory.dart';
import 'package:rotary/presentation/common_widgets/custom_textfield.dart';
import 'package:rotary/presentation/features/directory/directory_cubit.dart';
import 'package:rotary/presentation/pages/directory/directory_detail_page.dart';
import 'package:rotary/presentation/pages/directory/more_directory.dart';
import 'package:rotary/presentation/pages/directory/directory_search_page.dart';

class DirectoryPage extends StatelessWidget {
  DirectoryPage({Key? key}) : super(key: key);
  final adsSlider = [
    "assets/images/image 12.png",
    'assets/images/image 12.png',
    'assets/images/image 12.png'
  ];

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      triggerMode: RefreshIndicatorTriggerMode.anywhere,
      onRefresh: () =>
          BlocProvider.of<DirectoryCubit>(context).getDirectoryData(),
      child: BlocBuilder<DirectoryCubit, DirectoryState>(
        builder: (context, state) {
          if (state is DirectoryInitial) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is DirectoryError) {
            return Center(
              child: Text(state.errorMessage),
            );
          } else if (state is DirectoryLoaded) {
            final topBannerAds =
                BlocProvider.of<DirectoryCubit>(context).homeTopBannerAds;
            final topAds = BlocProvider.of<DirectoryCubit>(context).homeTopAds;
            List<BusinessDirectory> businessDirectoriesList =
                state.businessDirectory;
            List<BusinessDirectory> moreBusinessDirectoriesList = [];
            if (businessDirectoriesList.length > 15) {
              businessDirectoriesList = businessDirectoriesList.sublist(0, 8);
              businessDirectoriesList.add(BusinessDirectory(name: 'More'));
              moreBusinessDirectoriesList = state.businessDirectory
                  .sublist(8, state.businessDirectory.length);
            }
            final bottomAds =
                BlocProvider.of<DirectoryCubit>(context).homeBottomAds;

            return CustomScrollView(
              // controller: _sc,
              // physics: BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: Container(
                    height: 220,
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            Container(
                              height: 175,
                              child: Row(
                                children: [
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 20),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text.rich(
                                            TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: 'Let us help you\n',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 20,
                                                    fontFamily: 'Barlow',
                                                    fontWeight: FontWeight.w700,
                                                    height: 0,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: 'Connecting',
                                                  style: TextStyle(
                                                    color: AppColors.darkRed,
                                                    fontSize: 20,
                                                    fontFamily: 'Barlow',
                                                    fontWeight: FontWeight.w700,
                                                    height: 0,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: ' Rotarians',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 20,
                                                    fontFamily: 'Barlow',
                                                    fontWeight: FontWeight.w700,
                                                    height: 0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            'Over more than 6000 professional from all over Nepal - Bhutan.',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                              fontFamily: 'Barlow',
                                              fontWeight: FontWeight.w400,
                                              height: 0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  topBannerAds != null
                                      ? Image.network(
                                          topBannerAds.image!,
                                          height: 120,
                                          width: 130,
                                        )
                                      : Image.asset(
                                          'assets/images/directory_home.png'),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Container(
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                bottom: 20, left: 16, right: 16),
                            child: CustomTextField(
                              prefixIcon: Icon(CupertinoIcons.search),
                              readOnly: true,
                              borderColor: Colors.grey,
                              hintText: "Search directory name ...",
                              // controller: BlocProvider.of<DirectoryCubit>(context)
                              //     .searchDirectoryController,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DirectorySearchPage(
                                        classifications:
                                            state.businessDirectory),
                                  ),
                                );
                              },

                              // onChanged: (value) {
                              //   print(value);
                              //   BlocProvider.of<DirectoryCubit>(context)
                              //       .searchDirectory(value);
                              // },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: topAds.isNotEmpty
                      ? Container(
                          height: 90,
                          child: CarouselSlider(
                              options: CarouselOptions(
                                viewportFraction: 0.8,
                                autoPlay: true,
                                autoPlayInterval: Duration(seconds: 3),
                                pauseAutoPlayInFiniteScroll: false,
                                autoPlayAnimationDuration: Duration(seconds: 1),
                                autoPlayCurve: Curves.fastOutSlowIn,
                                enlargeCenterPage: true,
                                scrollDirection: Axis.horizontal,
                                // onPageChanged: (index, reason) {
                                //   setState(() {
                                //     _current = index;
                                //   });
                                // },
                              ),
                              items: topAds.map((e) {
                                int index = topAds.indexOf(e);
                                return Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        topAds[index].image!,
                                      ),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                );
                              }).toList()),
                        )
                      : SizedBox(),
                ),
                SliverToBoxAdapter(
                  child: SingleChildScrollView(
                    // physics: ClampingScrollPhysics(),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 20, bottom: 20),
                          color: Colors.white,
                          child: GridView.builder(
                              shrinkWrap: true,
                              // controller: _sc,
                              physics: BouncingScrollPhysics(),
                              // physics: NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                              // shrinkWrap: true,
                              itemCount: businessDirectoriesList.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                childAspectRatio: 82 / 75,
                              ),
                              itemBuilder: (context, index) {
                                // String clubName = clubs?.clubs[index].club ?? "";
                                return InkWell(
                                  onTap: () async {
                                    // await BlocProvider.of<DirectoryCubit>(context)
                                    //     .getDistricts();
                                    if (businessDirectoriesList[index].name ==
                                        "More") {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MoreDirectory(
                                                    moreBusinessDirectoriesList:
                                                        moreBusinessDirectoriesList,
                                                  )));
                                    } else
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DirectoryDetailPage(
                                                    directoryTitle:
                                                        businessDirectoriesList[
                                                                    index]
                                                                .name ??
                                                            "",
                                                    directoryUser:
                                                        businessDirectoriesList[
                                                                    index]
                                                                .users ??
                                                            [],
                                                  )));
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color: index ==
                                              businessDirectoriesList.length - 1
                                          ? null
                                          : Color(0x0f1d4781),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        index ==
                                                businessDirectoriesList.length -
                                                    1
                                            ? Container(
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.grey[300],
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: Icon(
                                                    Icons.more_horiz,
                                                    color: AppColors.rotaryBlue,
                                                  ),
                                                ),
                                              )
                                            : SvgPicture.network(
                                                businessDirectoriesList[index]
                                                        .imageUrl ??
                                                    "",
                                                height: 30,
                                                width: 30,
                                                placeholderBuilder: (context) =>
                                                    Icon(
                                                  Icons.info,
                                                  color: AppColors.rotaryBlue,
                                                ),
                                              ),
                                        SizedBox(height: 5),
                                        AutoSizeText(
                                          businessDirectoriesList[index]
                                                  .name
                                                  ?.toUpperCase() ??
                                              "",
                                          // textAlign: TextAlign.center,
                                          style: AppStyles.kBB12,
                                          minFontSize: 8,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.center,
                                        ),
                                        // Row(
                                        //   mainAxisAlignment: MainAxisAlignment.center,
                                        //   children: [
                                        //     Expanded(
                                        //       child: AutoSizeText(
                                        //         clubs?.clubs[index].president ?? "",
                                        //         maxLines: 1,
                                        //         minFontSize: 5,
                                        //         // textAlign: TextAlign.center,
                                        //         style: AppStyles.kB10,
                                        //       ),
                                        //     ),
                                        //   ],
                                        // ),
                                        // AutoSizeText(
                                        //   clubs?.clubs[index].year ?? "",
                                        //   maxLines: 1,
                                        //   minFontSize: 5,
                                        //   // textAlign: TextAlign.center,
                                        //   style: AppStyles.kB10,
                                        // ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        bottomAds.isNotEmpty
                            ? Container(
                                height: 70,
                                margin:
                                    const EdgeInsets.only(left: 12, right: 12),
                                child: ListView.separated(
                                  itemCount: bottomAds.length,
                                  physics: ClampingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                    width: 10,
                                  ),
                                  itemBuilder: (ctx, index) {
                                    return Container(
                                      width: 110,
                                      clipBehavior: Clip.hardEdge,
                                      decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(4)),
                                      child: Image.network(
                                        bottomAds[index].image ?? "",
                                        width: 164,
                                        fit: BoxFit.cover,
                                      ),
                                    );
                                  },
                                ),
                              )
                            : SizedBox(),
                        SizedBox(
                          height: bottomAds.isEmpty ? 0 : 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
          return Center(
            child: Text("Error loading data"),
          );
        },
      ),
    );
  }
}
