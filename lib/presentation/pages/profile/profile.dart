import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rotary/core/injection/injection_container.dart';
import 'package:rotary/core/resources/app_strings.dart';
import 'package:rotary/core/resources/app_styles.dart';
import 'package:rotary/data/data_sources/user/user_local_data_sources.dart';
import 'package:rotary/presentation/features/auth_bloc/auth_bloc.dart';
import 'package:rotary/presentation/features/members_bloc/members_bloc.dart';
import 'package:rotary/presentation/features/sign_in_bloc/sign_in_bloc.dart';
import 'package:rotary/presentation/pages/profile/forget_password.dart';
import 'package:rotary/presentation/pages/profile/profile-general/business_profile_page.dart';
import 'package:rotary/presentation/pages/profile/profile-general/login_info_page.dart';
import 'package:rotary/presentation/pages/profile/profile-general/personal_profile_page.dart';
import 'package:rotary/presentation/pages/profile/profile-general/rotary_engagement_page.dart';

import '../../../core/utils/dialog_util.dart';
import '../../features/home_page_bloc/homepage_bloc.dart';

class ProfilePage extends StatefulWidget {
  final bool isLoggedIn;
  const ProfilePage({Key? key, required this.isLoggedIn}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // late bool isAuthenticated;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<AuthBloc>(context).add(CheckAuthenticationEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackgroundColor,
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: BlocListener<SignInBloc, SignInState>(
        // bloc: BlocProvider.of<SignInBloc>(context),
        listener: (context, state) {
          log(state.toString());
          if (state is SignInLoaded) {
            Navigator.pop(context);
            BlocProvider.of<AuthBloc>(context).add(CheckAuthenticationEvent());
            BlocProvider.of<MembersBloc>(context).add(GetAllMembersEvent());
            BlocProvider.of<HomepageBloc>(context).add(GetHomePageDataEvent());
          } else if (state is SignInLoggedOut) {
            Navigator.pop(context);
            BlocProvider.of<HomepageBloc>(context).add(GetHomePageDataEvent());
            BlocProvider.of<AuthBloc>(context).add(CheckAuthenticationEvent());
          } else if (state is SignInError) {
            Navigator.pop(context);
            Fluttertoast.showToast(msg: state.error);
          } else if (state is SignInLoading) {
            DialogUtils.showLoaderDialog(context, disableForceClose: false);
          } else if (state is SignInSuccess) {
            Navigator.pop(context);
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthSuccess) {
              if (state.isAuthenticated) {
                return LoggedIn();
              } else {
                return LoginPage();
              }
            }

            return LoginPage();
          },
          // child: isAuthenticated ? LoggedIn() : LoginPage(),
        ),
      ),
    );
  }
}

class LoggedIn extends StatefulWidget {
  const LoggedIn({Key? key}) : super(key: key);

  @override
  State<LoggedIn> createState() => _LoggedInState();
}

class _LoggedInState extends State<LoggedIn> {
  UserLocalDataSources userLocalDataSources = di();
  String? username;
  String? memberId;
  String? userImage;

  void getUserData() async {
    username = await userLocalDataSources.getUserName();
    memberId = await userLocalDataSources.getUserId();
    userImage = await userLocalDataSources.getUserImage();
    setState(() {});
    print('username: $username');
    print('memberId: $memberId');
    print('userImage: $userImage');
  }

  void initState() {
    super.initState();
    getUserData();

    // BlocProvider.of<AuthBloc>(context).add(CheckAuthenticationEvent());
  }

  @override
  Widget build(BuildContext context) {
    // getUserData();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Welcome, $username", style: AppStyles.kBB14),
              InkWell(
                  onTap: () {
                    BlocProvider.of<SignInBloc>(context).add(LogOutEvent());
                  },
                  child: Text("Log Out", style: AppStyles.kBB14)),
            ],
          ),
          SizedBox(height: 20),
          Container(
            height: 150,
            width: double.infinity,
            color: AppColors.rotaryGold,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.rotaryBlue,
                    border: Border.all(color: Colors.white, width: 2),
                    image: DecorationImage(
                      image: userImage!.startsWith("http")
                          ? CachedNetworkImageProvider(userImage ?? "")

                          /// TODO: call api to update the image url . currenly its showing the image file which is stored locally
                          // ignore: unnecessary_cast
                          : (FileImage(
                              File(userImage ?? ""),
                            ) as ImageProvider),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Text("$username",
                    // "${user.firstname} ${user.middlename ?? ""} ${user.lastname}",
                    style: AppStyles.kBB12),
                SizedBox(height: 5),
                Text("Member Id: $memberId", style: AppStyles.kB11),
              ],
            ),
          ),
          SizedBox(height: 20),
          Text("General".toUpperCase(), style: AppStyles.kBB14),
          SizedBox(height: 10),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PersonalProfilePage(),
                ),
              ).then((value) => getUserData());
            },
            child: Container(
              height: 60,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(width: 10),
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Color(0xffD4DCE2),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Icon(
                          Icons.settings,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(width: 20),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Personal Profile", style: AppStyles.kBB14),
                          Text("Update and Modify your profile",
                              style: AppStyles.kB11),
                        ],
                      )
                    ],
                  ),
                  Icon(Icons.keyboard_arrow_right)
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  // settings: RouteSettings(),

                  builder: (context) => RotaryEngagementPage(),
                ),
              );
            },
            child: Container(
              height: 60,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(width: 10),
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Color(0xffD4DCE2),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: SvgPicture.asset(
                            "assets/images/svg/rotary.svg",
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Rotary Engagement", style: AppStyles.kBB14),
                          Text("Service in the Rotary Club and District",
                              style: AppStyles.kB11),
                        ],
                      )
                    ],
                  ),
                  Icon(Icons.keyboard_arrow_right)
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  // settings: RouteSettings(),

                  builder: (context) => BusinessProfilePage(),
                ),
              );
            },
            child: Container(
              height: 60,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(width: 10),
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Color(0xffD4DCE2),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Icon(
                          Icons.business,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(width: 20),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Business Profile", style: AppStyles.kBB14),
                          Text("Promote your business and connect Rotarians",
                              style: AppStyles.kB11),
                        ],
                      )
                    ],
                  ),
                  Icon(Icons.keyboard_arrow_right)
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  // settings: RouteSettings(),

                  builder: (context) => LoginInfoPage(),
                ),
              );
            },
            child: Container(
              height: 60,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(width: 10),
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Color(0xffD4DCE2),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Icon(
                          Icons.privacy_tip,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(width: 20),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Login Info", style: AppStyles.kBB14),
                          Text("Change your password", style: AppStyles.kB11),
                        ],
                      )
                    ],
                  ),
                  Icon(Icons.keyboard_arrow_right)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController idEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  bool obscurePassword = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            Text(
              'Member Login',
              style: AppStyles.kBB14,
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'Member ID',
              style: AppStyles.kB14,
            ),
            SizedBox(
              height: 5,
            ),
            SizedBox(
              height: 40,
              child: TextField(
                controller: idEditingController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'Password',
              style: AppStyles.kB14,
            ),
            SizedBox(
              height: 5,
            ),
            SizedBox(
              height: 40,
              child: TextField(
                obscureText: obscurePassword,
                controller: passwordEditingController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  fillColor: Colors.white,
                  filled: true,
                  suffixIcon: IconButton(
                      icon: obscurePassword
                          ? Icon(Icons.visibility_off)
                          : Icon(Icons.visibility),
                      onPressed: () {
                        setState(() {
                          obscurePassword = !obscurePassword;
                        });
                      }),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ForgetPassword();
                  }));
                },
                child: Text(
                  'Forgot Password?',
                  style: AppStyles.kB14,
                )),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                if (idEditingController.text.length > 0 &&
                    passwordEditingController.text.length > 0) {
                  BlocProvider.of<SignInBloc>(context).add(
                    LoginEvent(
                      username: idEditingController.text,
                      password: passwordEditingController.text,
                    ),
                  );
                }
              },
              child: Container(
                alignment: Alignment.center,
                height: 40,
                width: 100,
                color: AppColors.rotaryGold,
                child: Text(
                  "Login",
                  style: AppStyles.kBB14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
