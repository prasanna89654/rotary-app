
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rotary/core/injection/injection_container.dart';
import 'package:rotary/core/resources/app_strings.dart';
import 'package:rotary/core/resources/app_styles.dart';
import 'package:rotary/data/models/notification/notification_response.dart';
import 'package:rotary/presentation/common_widgets/drawer.dart';
import 'package:rotary/presentation/features/notification/notification_bloc.dart';
import 'package:rotary/presentation/pages/club/club_page.dart';
import 'package:rotary/presentation/pages/dg_page/district_governer_page.dart';
import 'package:rotary/presentation/pages/directory/directory_page.dart';
import 'package:rotary/presentation/pages/gml/gml_page.dart';
import 'package:rotary/presentation/pages/homepage/district_committee_page.dart';
import 'package:rotary/presentation/pages/homepage/homepage.dart';
import 'package:rotary/presentation/pages/new_calendar_page.dart';
import 'package:rotary/presentation/pages/resource_page/resources_page.dart';
import 'package:rotary/presentation/pages/members/members_page.dart';

import '../../features/auth_bloc/auth_bloc.dart';
import '../../features/home_page_bloc/homepage_bloc.dart';
import '../../notification_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  List<Widget> pages = [
    HomePage(),
    // EventsPage(),
    DGNewCalendarBody(),
    GMLPageBody(),
    ClubPage(),
    MembersPage(),
  ];
  List<Widget> topPages = [
    HomePage(),
    DistrictGovernerPage(),
    DistrictComitteePage(),
    ResourcesPage(),
    DirectoryPage()
  ];
  late TabController _tabController;

  int _selectedPage = 0;
  int _selectedTopPage = 0;
  List<String> _topPageTitles = [
    "Top Stories",
    "District Governors",
    "District Committee",
    "Resources",
    "Directory"
  ];

  late NotificationBloc notificationBloc;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(initialIndex: 0, length: topPages.length, vsync: this);
    notificationBloc = NotificationBloc(
      di(),
      di(),
      BlocProvider.of<HomepageBloc>(context),
    );
    BlocProvider.of<HomepageBloc>(context).add(GetHomePageDataEvent());
  }

  NotificationResponseModel? notificationResponseModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackgroundColor,
      appBar: AppBar(
          title: Text(
            "RI District 3292".toUpperCase(),
            style: TextStyle(
              color: AppColors.rotaryGold,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            StreamBuilder(
              stream: notificationBloc.notificationRx.stream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  notificationResponseModel =
                      snapshot.data as NotificationResponseModel;
                }
                return BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    return InkWell(
                      onTap: () {
                        if (state is AuthSuccess) {
                          if (state.isAuthenticated) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NotificationPage(
                                  notificationBloc: notificationBloc,
                                ),
                              ),
                            );
                          } else {
                            Fluttertoast.showToast(
                                msg: "Please login to check notifications");
                          }
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Icon(
                              Icons.notifications,
                              size: 28,
                            ),
                            notificationResponseModel?.unreadCount == null ||
                                    notificationResponseModel?.unreadCount == 0
                                ? SizedBox()
                                : Positioned(
                                    right: 0,
                                    top: 10,
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 15,
                                      width: 15,
                                      decoration: BoxDecoration(
                                        color: AppColors.rotaryGold,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Text(
                                        "${notificationResponseModel?.unreadCount ?? ""}",
                                        style: AppStyles.kB10.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  )
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            )
          ],
          bottom: TabBar(
              controller: _tabController,
              padding: EdgeInsets.only(left: 10),
              indicatorSize: TabBarIndicatorSize.label,
              splashFactory: NoSplash.splashFactory,
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              labelPadding: const EdgeInsets.only(
                left: 0,
              ),
              onTap: (index) {
                setState(() {
                  _selectedPage = 0;
                  _selectedTopPage = index;
                });
                if (index == 1) {
                  // BlocProvider.of<DistrictGovernorBloc>(context)
                  //     .add(GetAllDistrictGovernors());
                } else if (index == 2) {
                  // BlocProvider.of<DistrictcommitteeBloc>(context)
                  //     .add(GetAllDistrictCommitteesEvent());
                } else if (index == 3) {
                  // BlocProvider.of<ResourcesBloc>(context)
                  //     .add(GetAllResourcesEvent());
                }
              },
              isScrollable: true,
              tabs: _topPageTitles.map((title) {
                int index = _topPageTitles.indexOf(title);
                return Tab(
                  child: Container(
                    margin: index == 4 ? EdgeInsets.only(right: 10) : null,
                    decoration: BoxDecoration(
                      color: index == _selectedTopPage
                          ? Colors.white
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 12,
                          color: index == _selectedTopPage
                              ? Colors.black
                              : Colors.white70,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList())),
      drawer: DrawerWidget(),
      body: _selectedTopPage == -1
          ? pages[_selectedPage]
          : topPages[_selectedTopPage],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.rotaryBlue,
        unselectedItemColor: Colors.black,
        selectedIconTheme: IconThemeData(
          color: AppColors.rotaryBlue,
        ),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        unselectedLabelStyle: TextStyle(color: Colors.black),
        currentIndex: _selectedPage,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset("assets/images/home.png"),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Image.asset("assets/images/events.png"),
            label: "Calendar",
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/images/newspaper-folded.png",
              height: 20,
            ),
            label: "GML",
          ),
          BottomNavigationBarItem(
            icon: Image.asset("assets/images/club.png"),
            label: "Club",
          ),
          BottomNavigationBarItem(
            icon: Image.asset("assets/images/member.png"),
            label: "Members",
          )
        ],
        onTap: (index) {
          setState(() {
            _selectedPage = index;
          });
          if (index != 0) {
            _selectedTopPage = -1;
          }
          if (index == 0) {
            _selectedTopPage = 0;
          }
        },
      ),
    );
  }
}
