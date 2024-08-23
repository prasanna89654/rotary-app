import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rotary/core/injection/injection_container.dart';
import 'package:rotary/core/simple_bloc_observer.dart';
import 'package:rotary/presentation/features/auth_bloc/auth_bloc.dart';
import 'package:rotary/presentation/features/calendar_bloc/calendar_bloc.dart';
import 'package:rotary/presentation/features/directory/directory_cubit.dart';
import 'package:rotary/presentation/features/district_governor_bloc/district_governor_bloc.dart';
import 'package:rotary/presentation/features/clubs/clubs_bloc.dart';
import 'package:rotary/presentation/features/district_committee_bloc/districtcommittee_bloc.dart';
import 'package:rotary/presentation/features/event/event_bloc.dart';
import 'package:rotary/presentation/features/gml_bloc/gml_bloc.dart';
import 'package:rotary/presentation/features/home_page_bloc/homepage_bloc.dart';
import 'package:rotary/presentation/features/members_bloc/members_bloc.dart';
import 'package:rotary/presentation/features/news_bloc/news_bloc.dart';
import 'package:rotary/presentation/features/notification/notification_bloc.dart';
import 'package:rotary/presentation/features/profile_bloc/profile_bloc.dart';
import 'package:rotary/presentation/features/resources_bloc/resources_bloc.dart';
import 'package:rotary/presentation/features/sign_in_bloc/sign_in_bloc.dart';
import 'package:rotary/presentation/notification_page.dart';
import 'package:rotary/presentation/pages/splash/splash_page.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await ServiceLocator.init();

  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  NotificationSettings settings = await firebaseMessaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    print('User granted provisional permission');
  } else {
    print('User declined or has not accepted permission');
  }
  // await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
  //   alert: true,
  //   badge: true,
  //   sound: true,
  // );
  Bloc.observer = SimpleBlocObserver();
  _testSub(firebaseMessaging);
  runApp(const MyApp());
}

const String testTopic = 'TEST_TOPIC';

void _testSub(FirebaseMessaging firebaseMessaging) {
  if (kDebugMode) {
    firebaseMessaging.subscribeToTopic(testTopic);
  }
}

GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
                  di(),
                  di(),
                )..add(CheckAuthenticationEvent())),
        BlocProvider<SignInBloc>(
          create: (context) => SignInBloc(di(), di(), di(), di()),
        ),
        BlocProvider<HomepageBloc>(
          create: (context) => HomepageBloc(
            di(),
            di(),
            di(),
          ),
        ),
        BlocProvider<HomepageBloc>(
          create: (context) => HomepageBloc(
            di(),
            di(),
            di(),
          ),
        ),
        BlocProvider<ClubsBloc>(
          create: (context) => ClubsBloc(
            getClubsUseCase: di(),
            getClubDetailsUseCase: di(),
          ),
        ),
        BlocProvider<NewsBloc>(
          create: (context) => NewsBloc(
            di(),
            di(),
          ),
        ),
        BlocProvider<MembersBloc>(
          create: (context) => MembersBloc(
            di(),
            di(),
            BlocProvider.of<AuthBloc>(context),
          ),
        ),
        BlocProvider<DistrictcommitteeBloc>(
          create: (context) => DistrictcommitteeBloc(
            di(),
          ),
        ),
        BlocProvider<DistrictGovernorBloc>(
          create: (context) => DistrictGovernorBloc(
            di(),
            di(),
          ),
        ),
        BlocProvider<ResourcesBloc>(
          create: (context) => ResourcesBloc(di(), di(), di()),
        ),
        BlocProvider<GmlBloc>(
          create: (context) => GmlBloc(
            di(),
            di(),
          ),
        ),
        BlocProvider<EventBloc>(
          create: (context) => EventBloc(
            di(),
          ),
        ),
        BlocProvider<CalendarBloc>(
          create: (context) => CalendarBloc(
            di(),
          ),
        ),
        BlocProvider<ProfileBloc>(
          create: (context) => ProfileBloc(
            di(),
            di(),
          ),
        ),
        BlocProvider<DirectoryCubit>(
          create: (context) => DirectoryCubit(
            di(),
          ),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: _navigatorKey,
          title: 'Rotary Club',
          theme: ThemeData(
            fontFamily: 'Barlow',
            primarySwatch: royalBlue,
            primaryColor: Colors.white,
            appBarTheme: AppBarTheme(foregroundColor: Colors.white),
          ),
          home: RootPage()),
    );
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  Future<void> listenToNotification() async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      print("onMessage: ${event.data}");
      if (event.data['notificationIdentifier'] == 'TEST_TOPIC') {
        //
        // certain topic received
        print(event.notification?.title);
      }
      // if(event.data['notificationIdentifier'] == 'events') {
      bool isAuthenticated =
          BlocProvider.of<AuthBloc>(_navigatorKey.currentState!.context)
              .isAuthenticated;
      if (isAuthenticated) {
        Fluttertoast.showToast(
            msg: event.notification!.title!, gravity: ToastGravity.SNACKBAR);
        BlocProvider.of<HomepageBloc>(_navigatorKey.currentState!.context)
            .add(GetHomePageDataEvent());
      }

      // }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      print("From onMessageApp");
      bool isAuthenticated =
          BlocProvider.of<AuthBloc>(_navigatorKey.currentState!.context)
              .isAuthenticated;
      if (isAuthenticated) {
        BlocProvider.of<HomepageBloc>(_navigatorKey.currentState!.context)
            .add(GetHomePageDataEvent());
        NotificationBloc notificationBloc = NotificationBloc(
          di(),
          di(),
          BlocProvider.of<HomepageBloc>(_navigatorKey.currentState!.context),
        );
        Navigator.push(
            _navigatorKey.currentState!.context,
            MaterialPageRoute(
                builder: (context) =>
                    NotificationPage(notificationBloc: notificationBloc)));
      } else {
        Fluttertoast.showToast(
            msg: "Please login to check notifications",
            gravity: ToastGravity.SNACKBAR);
      }
    });

    // final RemoteMessage? message =
    //     await FirebaseMessaging.instance.getInitialMessage();
    // if (message != null) {
    //   print("From initial");
    //   NotificationBloc notificationBloc = NotificationBloc(
    //     di(),
    //     di(),
    //     BlocProvider.of<HomepageBloc>(context),
    //   );
    //   Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //           builder: (context) =>
    //               NotificationPage(notificationBloc: notificationBloc)));
    // }
  }

  @override
  void initState() {
    super.initState();
    listenToNotification();
  }

  @override
  Widget build(BuildContext context) {
    return SplashPage();
  }
}

Map<int, Color> color = {
  50: Color.fromRGBO(80, 94, 152, .1),
  100: Color.fromRGBO(80, 94, 152, .2),
  200: Color.fromRGBO(80, 94, 152, .3),
  300: Color.fromRGBO(80, 94, 152, .4),
  400: Color.fromRGBO(80, 94, 152, .5),
  500: Color.fromRGBO(80, 94, 152, .6),
  600: Color.fromRGBO(80, 94, 152, .7),
  700: Color.fromRGBO(80, 94, 152, .8),
  800: Color.fromRGBO(80, 94, 152, .9),
  900: Color.fromRGBO(80, 94, 152, 1),
};
Map<int, Color> colorGold = {
  50: Color.fromRGBO(226, 163, 80, .1),
  100: Color.fromRGBO(226, 163, 80, .2),
  200: Color.fromRGBO(226, 163, 80, .3),
  300: Color.fromRGBO(226, 163, 80, .4),
  400: Color.fromRGBO(226, 163, 80, .5),
  500: Color.fromRGBO(226, 163, 80, .6),
  600: Color.fromRGBO(226, 163, 80, .7),
  700: Color.fromRGBO(226, 163, 80, .8),
  800: Color.fromRGBO(226, 163, 80, .9),
  900: Color.fromRGBO(226, 163, 80, 1),
};

MaterialColor royalBlue = MaterialColor(0xFF505e98, color);
MaterialColor rotaryGold = MaterialColor(0xFFe2a350, colorGold);
