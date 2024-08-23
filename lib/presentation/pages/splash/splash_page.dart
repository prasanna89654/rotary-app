import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rotary/core/injection/injection_container.dart';
import 'package:rotary/core/resources/app_constants.dart';
import 'package:rotary/domain/repository/notification_repository.dart';
import 'package:rotary/presentation/features/clubs/clubs_bloc.dart';
import 'package:rotary/presentation/features/directory/directory_cubit.dart';
import 'package:rotary/presentation/features/district_committee_bloc/districtcommittee_bloc.dart';
import 'package:rotary/presentation/features/gml_bloc/gml_bloc.dart';
import 'package:rotary/presentation/features/members_bloc/members_bloc.dart';
import 'package:rotary/presentation/features/resources_bloc/resources_bloc.dart';
import 'package:rotary/presentation/pages/homepage/mainpage.dart';

import '../../features/calendar_bloc/calendar_bloc.dart';
import '../../features/district_governor_bloc/district_governor_bloc.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late AnimationController logoAnimController;

  late Animation<double> logoFadeAnim;
  NotificationRepository _notificationRepository = di();
  void subscribeToEvents() async {
    await _notificationRepository.subscribeToTopic(AppConstant.EVENT_TOPIC);
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<DistrictGovernorBloc>(context)
        .add(GetAllDistrictGovernors());
    // BlocProvider.of<HomepageBloc>(context).add(GetHomePageDataEvent());
    BlocProvider.of<DistrictcommitteeBloc>(context)
        .add(GetAllDistrictCommitteesEvent());
    BlocProvider.of<ResourcesBloc>(context).add(GetAllResourcesEvent());

    BlocProvider.of<ClubsBloc>(context).add(GetAllClubsEvent());
    BlocProvider.of<MembersBloc>(context).add(GetAllMembersEvent());
    BlocProvider.of<CalendarBloc>(context).add(LoadCalendarAllEvent());
    BlocProvider.of<GmlBloc>(context).add(GetAllGmlEvent());
    BlocProvider.of<DirectoryCubit>(context).getDirectoryData();
    // BlocProvider.of<DirectoryCubit>(context).getDistricts();
    logoAnimController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    logoFadeAnim = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: logoAnimController,
        curve: Curves.ease,
      ),
    );

    logoAnimController.forward();

    /// subscribe to events Notification
    subscribeToEvents();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(Duration(seconds: 3), () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (mounted) => MainPage()));
      });
    });
  }

  @override
  void dispose() {
    logoAnimController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(60),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeTransition(
              opacity: logoFadeAnim,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1, 0),
                  end: const Offset(0, 0),
                ).animate(CurvedAnimation(
                    parent: logoAnimController,
                    curve: Curves.fastLinearToSlowEaseIn)),
                child: Image.asset("assets/images/logo.png"),
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
