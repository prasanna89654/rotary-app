import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rotary/core/resources/app_strings.dart';
import 'package:rotary/core/resources/app_styles.dart';
import 'package:rotary/core/utils/dialog_util.dart';
import 'package:rotary/data/models/member/member_model.dart';
import 'package:rotary/data/models/member/member_pagination_request_model.dart';
import 'package:rotary/data/models/member/search_member_request_model.dart';
import 'package:rotary/presentation/common_widgets/custom_textfield.dart';
import 'package:rotary/presentation/features/auth_bloc/auth_bloc.dart';
import 'package:rotary/presentation/features/home_page_bloc/homepage_bloc.dart';
import 'package:rotary/presentation/features/members_bloc/members_bloc.dart';
import 'package:rotary/presentation/features/sign_in_bloc/sign_in_bloc.dart';
import 'package:rotary/presentation/pages/profile/profile.dart';
import 'package:url_launcher/url_launcher.dart';

class MembersPage extends StatefulWidget {
  const MembersPage({Key? key}) : super(key: key);

  @override
  State<MembersPage> createState() => _MembersPageState();
}

class _MembersPageState extends State<MembersPage> {
  final ScrollController _scrollController =
      ScrollController(initialScrollOffset: 0.0, keepScrollOffset: true);
  // final ScrollController _customScrollView =
  //     ScrollController(initialScrollOffset: 0.0, keepScrollOffset: true);
  final TextEditingController _searchController = TextEditingController();
  dynamic pageNumber = 1;
  List<MemberModel> members = [];
  String advFilter = "";
  late StreamSubscription<bool> keyboardSubscription;
  // late bool isAuthenticated;

  // Future<void> _makePhoneCall(String phoneNumber) async {
  //   final Uri launchUri = Uri(
  //     scheme: 'tel',
  //     path: phoneNumber,
  //   );
  //   await launchUrl(launchUri);
  // }

  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  // Future<void> _sendMail(String email) async {
  //   try {
  //     final Uri emailLaunchUri = Uri(
  //       scheme: 'mailto',
  //       path: email,
  //       query: encodeQueryParameters(<String, String>{
  //         'subject': 'Example Subject & Symbols are allowed!'
  //       }),
  //     );
  //     if (await canLaunchUrl(emailLaunchUri)) {
  //       await launchUrl(emailLaunchUri);
  //     }
  //   } catch (e) {
  //     throw e;
  //   }
  // }

  MemberPaginationRequestModel memberPaginationRequestModel =
      MemberPaginationRequestModel(page: 1, isLastPage: false);
  @override
  void initState() {
    super.initState();
    // isAuthenticated = BlocProvider.of<AuthBloc>(context).isAuthenticated;

    // print("isAuthenticated: $isAuthenticated");

    BlocProvider.of<AuthBloc>(context).add(CheckAuthenticationEvent());

    // BlocProvider.of<MembersBloc>(context).add(GetAllMembersEvent());
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        memberPaginationRequestModel.page = pageNumber;
        memberPaginationRequestModel.isLastPage =
            pageNumber == null ? true : false;
        memberPaginationRequestModel.isLastPage
            ? null
            : BlocProvider.of<MembersBloc>(context)
                .add(LoadNextPageMembersEvent(memberPaginationRequestModel));
      }
    });
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
    return BlocListener<SignInBloc, SignInState>(
      listener: (context, state) {
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
        }
      },
      child: BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
        // if (state is AuthInitial) {
        //   if (state.isAuthenticated) {
        //     BlocProvider.of<MembersBloc>(context).add(GetAllMembersEvent());
        //   } else {

        //   }
        // }
      }, builder: (context, state) {
        if (state is AuthSuccess) {
          if (state.isAuthenticated) {
            // BlocProvider.of<MembersBloc>(context).add(GetAllMembersEvent());
            return RefreshIndicator(
              onRefresh: () async => BlocProvider.of<MembersBloc>(context).add(
                GetAllMembersEvent(),
              ),
              child: CustomScrollView(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                controller: _scrollController,
                slivers: [
                  // CustomAppBar(),
                  SliverToBoxAdapter(
                      child: Column(children: [
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              controller: _searchController,
                              hintText: "Search Rotarians name ...",
                              onSubmitted: (value) {
                                SearchMemberRequestModel
                                    searchMemberRequestModel =
                                    SearchMemberRequestModel(
                                  search: value,
                                );
                                BlocProvider.of<MembersBloc>(context).add(
                                    SearchMembersEvent(
                                        searchMemberRequestModel));
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
                                        alignment: Alignment.center,
                                        actionsAlignment:
                                            MainAxisAlignment.center,
                                        title: Text("Sort by"),
                                        content: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                setstate(() {
                                                  setState(() {
                                                    advFilter = "ASC";
                                                  });
                                                });
                                                SearchMemberRequestModel
                                                    searchMemberRequestModel =
                                                    SearchMemberRequestModel(
                                                        search: "ASC",
                                                        isSearch: false);
                                                BlocProvider.of<MembersBloc>(
                                                        context)
                                                    .add(SearchMembersEvent(
                                                        searchMemberRequestModel));
                                                Navigator.pop(context);
                                              },
                                              child: Row(
                                                children: [
                                                  advFilter == "ASC"
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
                                                    advFilter = "DESC";
                                                  });
                                                });
                                                SearchMemberRequestModel
                                                    searchMemberRequestModel =
                                                    SearchMemberRequestModel(
                                                        search: "DESC",
                                                        isSearch: false);
                                                BlocProvider.of<MembersBloc>(
                                                        context)
                                                    .add(SearchMembersEvent(
                                                        searchMemberRequestModel));
                                                Navigator.pop(context);
                                              },
                                              child: Row(
                                                children: [
                                                  advFilter == "DESC"
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
                  ])),
                  BlocConsumer<MembersBloc, MembersState>(
                    listener: (context, state) {
                      if (state is MembersLoadedState) {
                        members = state.memberResponseModel.members;
                        print(pageNumber);
                        print(state.memberResponseModel.isLastPage());
                        !state.memberResponseModel.isLastPage()
                            ? pageNumber =
                                state.memberResponseModel.currentPage + 1
                            : pageNumber = null;
                      }
                    },
                    builder: (context, state) {
                      if (state is MembersLoadingState) {
                        return SliverFillRemaining(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      if (state is MembersErrorState) {
                        return SliverFillRemaining(
                          fillOverscroll: true,
                          child: Center(
                            child: Text(state.error),
                          ),
                        );
                      }
                      if (state is MembersLoadedState) {
                        members = state.memberResponseModel.members;
                      }
                      return SliverToBoxAdapter(child: _buildBody());
                    },
                  ),
                ],
              ),
            );
          } else {
            return LoginPage();
          }
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      }),
    );
  }

  Widget _buildBody() {
    return GridView.builder(
      shrinkWrap: true,
      // controller: _scrollController,
      physics: BouncingScrollPhysics(),
      itemCount: members.isNotEmpty ? members.length : 0,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 1.05,
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.all(8),
          // color: Colors.white,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: CachedNetworkImageProvider(members[index].image),
                        fit: BoxFit.cover),
                    color: AppColors.rotaryGold,
                    shape: BoxShape.circle),
              ),
              SizedBox(height: 10),
              AutoSizeText(
                members[index].name ?? "",
                style: AppStyles.kBB12,
                maxLines: 1,
                minFontSize: 8,
                overflow: TextOverflow.ellipsis,
              ),
              AutoSizeText(
                members[index].club ?? "",
                style: AppStyles.kB10,
                textAlign: TextAlign.center,
                minFontSize: 8,
                maxLines: 1,
              ),
              // SizedBox(height: 5),
              members[index].email == "" || members[index].email == null
                  ? SizedBox()
                  : InkWell(
                      onTap: () async {
                        final url = Uri(
                          scheme: "mailto",
                          path: members[index].email,
                        );
                        bool _canlaunch = await canLaunchUrl(url);
                        if (_canlaunch) {
                          launchUrl(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                      child: AutoSizeText(
                        members[index].email ?? "",
                        style: AppStyles.kB10,
                        minFontSize: 5,
                        maxLines: 1,
                      ),
                    ),

              members[index].phone == "" || members[index].phone == null
                  ? SizedBox()
                  : InkWell(
                      onTap: () async {
                        final url = Uri(
                          scheme: "tel",
                          path: members[index].phone,
                        );
                        bool _canlaunch = await canLaunchUrl(url);
                        if (_canlaunch) {
                          launchUrl(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                      child: AutoSizeText(
                        members[index].phone ?? "",
                        style: AppStyles.kB10,
                        minFontSize: 5,
                        maxLines: 1,
                      ),
                    ),
              members[index].classification == "" ||
                      members[index].classification == null
                  ? SizedBox()
                  : AutoSizeText(
                      members[index].classification ?? "",
                      style: AppStyles.kB10,
                      minFontSize: 5,
                      maxLines: 1,
                    ),
            ],
          ),
        );
      },
    );
  }
}
