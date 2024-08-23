import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import 'package:rotary/core/resources/app_styles.dart';
import 'package:rotary/domain/entities/club/club.dart';
import 'package:rotary/presentation/common_widgets/custom_textfield.dart';
import 'package:rotary/presentation/features/clubs/clubs_bloc.dart';
import 'package:rotary/presentation/pages/club/club_details_page.dart';

class ClubPage extends StatefulWidget {
  ClubPage({Key? key}) : super(key: key);

  @override
  State<ClubPage> createState() => _ClubPageState();
}

class _ClubPageState extends State<ClubPage> {
  final ScrollController _scrollController = ScrollController();
  Clubs? clubs;
  String advFilter = "";
  late StreamSubscription<bool> keyboardSubscription;

  @override
  void initState() {
    super.initState();
    // BlocProvider.of<ClubsBloc>(context).add(GetAllClubsEvent());
    var keyboardVisibilityController = KeyboardVisibilityController();
    keyboardSubscription =
        keyboardVisibilityController.onChange.listen((bool visible) {
      print('Keyboard visibility update. Is visible: $visible');
      if (!visible) {
        FocusScope.of(context).requestFocus(FocusNode());
      }
    });
  }

  @override
  void dispose() {
    keyboardSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return RefreshIndicator(
      onRefresh: () async => BlocProvider.of<ClubsBloc>(context).add(
        GetAllClubsEvent(),
      ),
      child: CustomScrollView(
        physics: BouncingScrollPhysics(),
        controller: _scrollController,
        slivers: [
          // CustomAppBar(),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      hintText: "Search club name ...",
                      onChanged: (value) {
                        print(value);
                        BlocProvider.of<ClubsBloc>(context)
                            .add(SearchClubEvent(searchText: value));
                      },
                    ),
                  ),
                  SizedBox(width: 30),
                  InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return StatefulBuilder(
                                builder: (context, setstate) {
                              return AlertDialog(
                                title: Text("Sort by"),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setstate(() {
                                          setState(() {
                                            advFilter = "asc";
                                          });
                                        });
                                        BlocProvider.of<ClubsBloc>(context).add(
                                            SortClubEvent(
                                                ascOrDesc: advFilter));
                                        Navigator.pop(context);
                                      },
                                      child: Row(
                                        children: [
                                          advFilter == "asc"
                                              ? Icon(Icons.check_box)
                                              : Icon(Icons
                                                  .check_box_outline_blank),
                                          // Checkbox(value: true, onChanged: (value) {}),
                                          Text("Ascending"),
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setstate(() {
                                          setState(() {
                                            advFilter = "desc";
                                          });
                                        });
                                        BlocProvider.of<ClubsBloc>(context).add(
                                            SortClubEvent(
                                                ascOrDesc: advFilter));
                                        Navigator.pop(context);
                                      },
                                      child: Row(
                                        children: [
                                          advFilter == "desc"
                                              ? Icon(Icons.check_box)
                                              : Icon(Icons
                                                  .check_box_outline_blank),
                                          // Checkbox(value: true, onChanged: (value) {}),
                                          Text("Descending"),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            });
                          });
                    },
                    child: Icon(
                      Icons.settings,
                      color: Color(0xff919191),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // )),
          BlocConsumer<ClubsBloc, ClubsState>(listener: (context, state) {
            // if (state is ClubsLoadedState) {
            //   print("ClubsLoadedState");
            //   clubs = state.clubs;
            // }
          }, builder: (context, state) {
            if (state is ClubsLoadingState) {
              return SliverFillRemaining(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (state is ClubsErrorState) {
              return SliverFillRemaining(
                child: Center(
                  child: Text(state.message),
                ),
              );
            }
            if (state is ClubsLoadedState) {
              print("ClubsLoadedState");
              clubs = state.clubs;
            }
            return SliverToBoxAdapter(
              child: Column(
                children: [
                  GridView.builder(
                      shrinkWrap: true,
                      controller: _scrollController,
                      physics: BouncingScrollPhysics(),
                      // physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                      // shrinkWrap: true,
                      itemCount: clubs?.clubs.length ?? 0,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: (screenSize.width / 2) / 80,
                      ),
                      itemBuilder: (context, index) {
                        // String firstLetter =
                        //     clubs?.clubs[index].club[0].toUpperCase() ?? "";
                        // String clubName = firstLetter +
                        //     clubs?.clubs[index].club.substring(1) ?? ""
                        String clubName = clubs?.clubs[index].club ?? "";
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ClubDetailsPage(
                                        clubName: clubName,
                                        id: clubs!.clubs[index].id)));
                          },
                          child: Stack(
                            children: [
                              Card(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Container(
                                  padding: const EdgeInsets.only(left: 35),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      AutoSizeText(
                                        "RC - " + clubName.toUpperCase(),
                                        // textAlign: TextAlign.center,
                                        style: AppStyles.kBB10,
                                        minFontSize: 8,
                                        maxLines: 2,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: AutoSizeText(
                                              clubs?.clubs[index].president ??
                                                  "",
                                              maxLines: 1,
                                              minFontSize: 5,
                                              // textAlign: TextAlign.center,
                                              style: AppStyles.kB10,
                                            ),
                                          ),
                                        ],
                                      ),
                                      AutoSizeText(
                                        clubs?.clubs[index].year ?? "",
                                        maxLines: 1,
                                        minFontSize: 5,
                                        // textAlign: TextAlign.center,
                                        style: AppStyles.kB10,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xffBE598D)),
                                  child: Text(
                                    clubs?.clubs[index].memberCount
                                            .toString() ??
                                        "",
                                    style: AppStyles.kWB12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

class SearchHeader extends SliverPersistentHeaderDelegate {
  final Widget child;
  SearchHeader({required this.child});
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(
      child: child,
    );
  }

  @override
  double get maxExtent => 80;

  @override
  double get minExtent => 80;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
