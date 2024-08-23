import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rotary/core/injection/injection_container.dart';
import 'package:rotary/core/resources/app_strings.dart';
import 'package:rotary/core/resources/app_styles.dart';
import 'package:rotary/core/utils/com_fun.dart';
import 'package:rotary/data/models/club/club_details_model/club_details_response_model.dart';
import 'package:rotary/data/models/club/club_details_model/club_details_request_model.dart';
import 'package:rotary/domain/entities/club/club_details/info.dart';
import 'package:rotary/domain/entities/club/club_details/member.dart';
import 'package:rotary/presentation/features/auth_bloc/auth_bloc.dart';
import 'package:rotary/presentation/features/clubs/clubs_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class ClubDetailsPage extends StatefulWidget {
  final String clubName;
  final String id;
  ClubDetailsPage({Key? key, required this.clubName, required this.id})
      : super(key: key);

  @override
  State<ClubDetailsPage> createState() => _ClubDetailsPageState();
}

class _ClubDetailsPageState extends State<ClubDetailsPage> {
  // List<ClubDetailsModel> clubDetails = [];
  ClubDetailsResponseModel? clubDetails;
  ClubsBloc _clubsBloc =
      ClubsBloc(getClubDetailsUseCase: di(), getClubsUseCase: di());

  @override
  void initState() {
    super.initState();
    _clubsBloc.add(GetClubDetailsEvent(
        clubDetailsRequestModel: ClubDetailsRequestModel(id: widget.id)));
  }

  bool checkToShowSecondContainer(ClubInfo clubInfo) {
    if (clubInfo.rotract == null &&
        clubInfo.interact == null &&
        clubInfo.rcc == null &&
        clubInfo.grantProject == null &&
        clubInfo.phf == null &&
        clubInfo.mphf == null &&
        clubInfo.rfsm == null) {
      return false;
    } else {
      return true;
    }
  }

  List<TextSpan> secondContainerData(ClubInfo clubInfo) {
    List<TextSpan> list = [];
    if (clubInfo.grantProject != null) {
      list.add(TextSpan(
        children: [
          TextSpan(text: 'Global grant: ', style: AppStyles.kB12),
          TextSpan(text: clubInfo.grantProject, style: AppStyles.kBB12),
        ],
      ));
    }
    if (clubInfo.rotract != null) {
      list.add(TextSpan(
        children: [
          TextSpan(text: 'Rotract: ', style: AppStyles.kB12),
          TextSpan(text: clubInfo.rotract, style: AppStyles.kBB12),
        ],
      ));
    }
    if (clubInfo.interact != null) {
      list.add(TextSpan(
        children: [
          TextSpan(text: 'Interact: ', style: AppStyles.kB12),
          TextSpan(text: clubInfo.interact, style: AppStyles.kBB12),
        ],
      ));
    }
    if (clubInfo.rcc != null) {
      list.add(TextSpan(
        children: [
          TextSpan(text: 'RCC: ', style: AppStyles.kB12),
          TextSpan(text: clubInfo.rcc, style: AppStyles.kBB12),
        ],
      ));
    }
    if (clubInfo.phf != null) {
      list.add(TextSpan(
        children: [
          TextSpan(text: 'PHF: ', style: AppStyles.kB12),
          TextSpan(text: clubInfo.phf, style: AppStyles.kBB12),
        ],
      ));
    }
    if (clubInfo.mphf != null) {
      list.add(TextSpan(
        children: [
          TextSpan(text: 'MPHF: ', style: AppStyles.kB12),
          TextSpan(text: clubInfo.mphf, style: AppStyles.kBB12),
        ],
      ));
    }
    if (clubInfo.rfsm != null) {
      list.add(TextSpan(
        children: [
          TextSpan(text: 'RFSM: ', style: AppStyles.kB12),
          TextSpan(text: clubInfo.rfsm, style: AppStyles.kBB12),
        ],
      ));
    }
    print("List" + list.toString());
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.clubName),
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.all(15),
        //     child: Icon(CupertinoIcons.info),
        //   )
        // ],
      ),
      body: BlocProvider(
        create: (context) => _clubsBloc,
        child: BlocConsumer<ClubsBloc, ClubsState>(
          listener: (context, state) {
            if (state is ClubDetailsLoadedState) {
              clubDetails = state.clubDetails;
            }
          },
          builder: (context, state) {
            if (state is ClubsLoadingState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is ClubsErrorState) {
              return Center(
                child: Text(state.message),
              );
            }
            if (state is ClubDetailsLoadedState) {
              ClubInfo clubInfo = state.clubDetails.info!;
              List<ClubMember> clubMembers = state.clubDetails.members ?? [];
              final clubTopMembers = state.clubDetails.topMembers ?? null;
              final clubBod = state.clubDetails.bod ?? null;
              print(clubMembers);
              print(clubInfo);
              print("Clubtopmember: $clubTopMembers");

              return SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/club.png',
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                AutoSizeText(
                                  'RC - ${clubInfo.club} - '.toUpperCase(),
                                  style: AppStyles.kBB12,
                                  maxLines: 1,
                                  minFontSize: 8,
                                ),
                                Expanded(
                                  child: AutoSizeText(
                                    'Club # ${clubInfo.clubId ?? ""}${clubInfo.charterDate == null ? '' : ", Charter " "${clubInfo.charterDate}"}'
                                        .toUpperCase(),
                                    style: AppStyles.kB10,
                                    maxLines: 1,
                                    minFontSize: 8,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      clubInfo.meetingVenue == null &&
                              clubInfo.meetingDay == null &&
                              clubInfo.meetingTime == null
                          ? SizedBox()
                          : Container(
                              margin:
                                  const EdgeInsets.only(top: 10, bottom: 10),
                              padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                              width: double.infinity,
                              height: 60,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: AppColors.rotaryGold),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  clubInfo.meetingVenue == null
                                      ? SizedBox()
                                      : Row(
                                          children: [
                                            AutoSizeText(
                                              'Meeting Venue: ',
                                              style: AppStyles.kB12,
                                              maxLines: 1,
                                              minFontSize: 8,
                                            ),
                                            Flexible(
                                              child: AutoSizeText(
                                                '${clubInfo.meetingVenue == null ? "" : clubInfo.meetingVenue}',
                                                style: AppStyles.kBB12,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                minFontSize: 8,
                                              ),
                                            ),
                                          ],
                                        ),
                                  Row(
                                    children: [
                                      clubInfo.meetingDay == null
                                          ? SizedBox()
                                          : AutoSizeText(
                                              'Day: ',
                                              style: AppStyles.kB12,
                                              maxLines: 1,
                                              minFontSize: 8,
                                            ),
                                      clubInfo.meetingDay == null
                                          ? SizedBox()
                                          : AutoSizeText(
                                              '${clubInfo.meetingDay == null ? "" : clubInfo.meetingDay}, ',
                                              style: AppStyles.kBB12,
                                              maxLines: 1,
                                              minFontSize: 8,
                                            ),
                                      clubInfo.meetingDay == null
                                          ? SizedBox()
                                          : AutoSizeText(
                                              'Time: ',
                                              style: AppStyles.kB12,
                                              maxLines: 1,
                                              minFontSize: 8,
                                            ),
                                      clubInfo.meetingDay == null
                                          ? SizedBox()
                                          : AutoSizeText(
                                              '${clubInfo.meetingTime == null ? "" : clubInfo.meetingTime}',
                                              style: AppStyles.kBB12,
                                              maxLines: 1,
                                              minFontSize: 8,
                                            ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                      checkToShowSecondContainer(clubInfo)
                          ? Container(
                              alignment: Alignment.centerLeft,
                              padding:
                                  const EdgeInsets.fromLTRB(20, 20, 20, 20),
                              // height: 60,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white,
                              ),
                              child: RichText(
                                text: TextSpan(
                                  children:
                                      secondContainerData(clubInfo).map((e) {
                                    int index = secondContainerData(clubInfo)
                                        .indexOf(e);
                                    return TextSpan(
                                      children: [
                                        e,
                                        index ==
                                                secondContainerData(clubInfo)
                                                        .length -
                                                    1
                                            ? TextSpan()
                                            : TextSpan(
                                                text: ', ',
                                                style: AppStyles.kBB12),
                                      ],
                                    );
                                  }).toList(),
                                  // clubInfo.grantProject != null
                                  //     ? TextSpan(
                                  //         text: "Global grant: ",
                                  //         style: AppStyles.kB12,
                                  //       )
                                  //     : TextSpan(),
                                  // clubInfo.grantProject != null
                                  //     ? TextSpan(
                                  //         text: "${clubInfo.grantProject}, ",
                                  //         style: AppStyles.kBB12,
                                  //       )
                                  //     : TextSpan(),
                                  // TextSpan(
                                  //   text: "Rotract: ",
                                  //   style: AppStyles.kB12,
                                  // ),
                                  // TextSpan(
                                  //   text: clubInfo.rotract!.isEmpty
                                  //       ? "0, "
                                  //       : "${clubInfo.rotract}, ",
                                  //   style: AppStyles.kBB12,
                                  // ),
                                  // TextSpan(
                                  //   text: "Interact: ",
                                  //   style: AppStyles.kB12,
                                  // ),
                                  // TextSpan(
                                  //   text: clubInfo.interact!.isEmpty
                                  //       ? "0, "
                                  //       : "${clubInfo.interact}, ",
                                  //   style: AppStyles.kBB12,
                                  // ),
                                  // TextSpan(
                                  //   text: "RCC: ",
                                  //   style: AppStyles.kB12,
                                  // ),
                                  // TextSpan(
                                  //   text: clubInfo.rcc!.isEmpty
                                  //       ? "0, "
                                  //       : "${clubInfo.rcc}, ",
                                  //   style: AppStyles.kBB12,
                                  // ),
                                  // TextSpan(
                                  //   text: "PHF: ",
                                  //   style: AppStyles.kB12,
                                  // ),
                                  // TextSpan(
                                  //   text: clubInfo.phf!.isEmpty
                                  //       ? "0, "
                                  //       : "${clubInfo.phf}, ",
                                  //   style: AppStyles.kBB12,
                                  // ),
                                  // TextSpan(
                                  //   text: "MPHF: ",
                                  //   style: AppStyles.kB12,
                                  // ),
                                  // TextSpan(
                                  //   text: clubInfo.mphf!.isEmpty
                                  //       ? "0, "
                                  //       : clubInfo.mphf ?? "0",
                                  //   style: AppStyles.kBB12,
                                  // ),
                                  // TextSpan(
                                  //   text: "Major donor: ",
                                  //   style: AppStyles.kB12,
                                  // ),
                                  // TextSpan(
                                  //   text: clubInfo.number == null
                                  //       ? "0, "
                                  //       : "${clubInfo.number}, ",
                                  //   style: AppStyles.kBB12,
                                  // ),
                                  // TextSpan(
                                  //   text: "RFSM: ",
                                  //   style: AppStyles.kB12,
                                  // ),
                                  // TextSpan(
                                  //   text: clubInfo.rfsm!.isEmpty
                                  //       ? "0, "
                                  //       : "${clubInfo.rfsm}, ",
                                  //   style: AppStyles.kBB12,
                                  // ),
                                  // ],
                                ),
                              ),
                            )
                          : SizedBox(),
                      SizedBox(
                        height: 20,
                      ),
                      clubTopMembers == null
                          ? SizedBox()
                          : GridView(
                              padding: EdgeInsets.zero,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 1.4,
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 16,
                              ),
                              children: [
                                Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: AppColors.rotaryGold,
                                    ),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 50,
                                            height: 50,
                                            decoration: BoxDecoration(
                                                color: Color.fromRGBO(
                                                    244, 215, 91, 1),
                                                image: DecorationImage(
                                                  image:
                                                      CachedNetworkImageProvider(
                                                          clubTopMembers
                                                              .president!
                                                              .image!),
                                                  fit: BoxFit.cover,
                                                ),
                                                border: Border.all(
                                                    width: 2,
                                                    color: Colors.white),
                                                shape: BoxShape.circle),
                                          ),
                                          SizedBox(height: 10),
                                          AutoSizeText(
                                              clubTopMembers.president?.name ??
                                                  "",
                                              style: AppStyles.kBB12,
                                              minFontSize: 10,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis),
                                          AutoSizeText(
                                            // "President",
                                            clubTopMembers.president?.year ??
                                                "",
                                            style: AppStyles.kB10,
                                            textAlign: TextAlign.center,
                                            minFontSize: 8,
                                          ),
                                        ])),
                                clubTopMembers.secretary == null
                                    ? SizedBox()
                                    : Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: AppColors.rotaryGold,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 50,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                color: Color.fromRGBO(
                                                    244, 215, 91, 1),
                                                image: DecorationImage(
                                                  image:
                                                      CachedNetworkImageProvider(
                                                          clubTopMembers
                                                              .secretary!
                                                              .image!),
                                                  fit: BoxFit.cover,
                                                ),
                                                border: Border.all(
                                                    width: 2,
                                                    color: Colors.white),
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            AutoSizeText(
                                                clubTopMembers
                                                        .secretary?.name ??
                                                    "",
                                                style: AppStyles.kBB12,
                                                minFontSize: 10,
                                                maxLines: 1,
                                                overflow:
                                                    TextOverflow.ellipsis),
                                            AutoSizeText(
                                              clubTopMembers.secretary?.year ??
                                                  "",
                                              // "Secretary",
                                              style: AppStyles.kB10,
                                              textAlign: TextAlign.center,
                                              minFontSize: 8,
                                            ),
                                          ],
                                        ),
                                      ),
                              ],
                            ),
                      clubBod == null
                          ? SizedBox()
                          : Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 5),
                                child: AutoSizeText(
                                    "Board of directors (2022-23)",
                                    style: AppStyles.kBB14,
                                    textAlign: TextAlign.center,
                                    minFontSize: 10,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis),
                              ),
                            ),
                      clubBod == null
                          ? SizedBox()
                          : GridView.builder(
                              shrinkWrap: true,
                              itemCount: clubBod.length,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio:
                                    ((screenSize(context).width - 60) / 2) / 50,
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 16,
                              ),
                              itemBuilder: (context, index) {
                                return Container(
                                  padding: const EdgeInsets.all(8),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      AutoSizeText(
                                        "${clubBod[index].role}",
                                        style: AppStyles.kBB12,
                                        textAlign: TextAlign.center,
                                        minFontSize: 8,
                                        maxLines: 1,
                                        maxFontSize: 12,
                                      ),
                                      AutoSizeText(
                                        "${clubBod[index].name}",
                                        style: AppStyles.kB10,
                                        textAlign: TextAlign.center,
                                        minFontSize: 8,
                                        maxLines: 1,
                                        maxFontSize: 10,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                      /*Container(
                              padding: const EdgeInsets.all(20),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white),
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "IPP: ",
                                      style: AppStyles.kB12,
                                    ),
                                    TextSpan(
                                      text: clubInfo.grantProject!.isEmpty
                                          ? "0, "
                                          : "${clubInfo.grantProject}, ",
                                      style: AppStyles.kBB12,
                                    ),
                                    TextSpan(
                                      text: "PE: ",
                                      style: AppStyles.kB12,
                                    ),
                                    TextSpan(
                                      text: clubInfo.rotract!.isEmpty
                                          ? "0, "
                                          : "${clubInfo.rotract}, ",
                                      style: AppStyles.kBB12,
                                    ),
                                    TextSpan(
                                      text: "Treasurer: ",
                                      style: AppStyles.kB12,
                                    ),
                                    TextSpan(
                                      text: clubInfo.interact!.isEmpty
                                          ? "0, "
                                          : "${clubInfo.interact}, ",
                                      style: AppStyles.kBB12,
                                    ),
                                    TextSpan(
                                      text: "Club admin chair: ",
                                      style: AppStyles.kB12,
                                    ),
                                    TextSpan(
                                      text: clubInfo.rcc!.isEmpty
                                          ? "0, "
                                          : "${clubInfo.rcc}, ",
                                      style: AppStyles.kBB12,
                                    ),
                                    TextSpan(
                                      text: "TRF chair: ",
                                      style: AppStyles.kB12,
                                    ),
                                    TextSpan(
                                      text: clubInfo.phf!.isEmpty
                                          ? "0, "
                                          : "${clubInfo.phf}, ",
                                      style: AppStyles.kBB12,
                                    ),
                                    TextSpan(
                                      text: "Membership chair: ",
                                      style: AppStyles.kB12,
                                    ),
                                    TextSpan(
                                      text: clubInfo.mphf!.isEmpty
                                          ? "0, "
                                          : clubInfo.mphf ?? "0",
                                      style: AppStyles.kBB12,
                                    ),
                                    TextSpan(
                                      text: "Public Image Chair: ",
                                      style: AppStyles.kB12,
                                    ),
                                    TextSpan(
                                      text: clubInfo.number == null
                                          ? "0, "
                                          : "${clubInfo.number}, ",
                                      style: AppStyles.kBB12,
                                    ),
                                    TextSpan(
                                      text: "Service Project Chair: ",
                                      style: AppStyles.kB12,
                                    ),
                                    TextSpan(
                                      text: clubInfo.rfsm!.isEmpty
                                          ? "0, "
                                          : "${clubInfo.rfsm}, ",
                                      style: AppStyles.kBB12,
                                    ),
                                    TextSpan(
                                      text: "Sgt-at-arms: ",
                                      style: AppStyles.kB12,
                                    ),
                                    TextSpan(
                                      text: clubInfo.rfsm!.isEmpty
                                          ? "0, "
                                          : "${clubInfo.rfsm}, ",
                                      style: AppStyles.kBB12,
                                    ),
                                  ],
                                ),
                              ),
                            ),*/
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Row(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                  color: Color(0xffBD598D)),
                              child: Text(
                                clubMembers.length.toString(),
                                // state.resourcesList[index].count.toString(),
                                style: AppStyles.kWB14,
                              ),
                            ),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AutoSizeText(
                                  "Members",
                                  style: AppStyles.kBB14,
                                ),
                                BlocBuilder<AuthBloc, AuthState>(
                                  builder: (context, state) {
                                    if (state is AuthSuccess) {
                                      if (state.isAuthenticated) {
                                        return SizedBox();
                                      } else {
                                        return AutoSizeText(
                                          "Contact details are only visible for logged-in users",
                                          style: AppStyles.kB10,
                                        );
                                      }
                                    } else {
                                      return AutoSizeText(
                                        "Contact details are only visible for logged-in users",
                                        style: AppStyles.kB10,
                                      );
                                    }
                                  },
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: clubMembers.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio:
                                (screenSize(context).width / 2 - 50) / 60),
                        itemBuilder: (context, index) {
                          print(clubMembers[index].phoneNo);
                          return Container(
                            padding: const EdgeInsets.all(5),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AutoSizeText(
                                  clubMembers[index].name ?? "",
                                  style: AppStyles.kBB12,
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  minFontSize: 8,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                InkWell(
                                  onTap: () async {
                                    final url = Uri(
                                      scheme: "mailto",
                                      path: clubMembers[index].email,
                                    );
                                    bool _canlaunch = await canLaunchUrl(url);
                                    if (_canlaunch) {
                                      launchUrl(url);
                                    } else {
                                      throw 'Could not launch $url';
                                    }
                                  },
                                  child: AutoSizeText(
                                    clubMembers[index].email ?? "",
                                    style: AppStyles.kB10,
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    minFontSize: 8,
                                  ),
                                ),
                                InkWell(
                                  onTap: () async {
                                    final url = Uri(
                                      scheme: "tel",
                                      path: clubMembers[index].phoneNo,
                                    );
                                    bool _canlaunch = await canLaunchUrl(url);
                                    if (_canlaunch) {
                                      launchUrl(url);
                                    } else {
                                      throw 'Could not launch $url';
                                    }
                                  },
                                  child: AutoSizeText(
                                    clubMembers[index].phoneNo ?? "",
                                    style: AppStyles.kB10,
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    minFontSize: 8,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}

//old code

/*
return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              controller: _scrollController,
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      alignment: Alignment.center,
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.withOpacity(0.5),
                      ),
                      child: Text("Club Heads", style: AppStyles.kBB20)),
                  const SizedBox(height: 10),
                  MembersWidget(
                    isHeadMember: true,
                    name: "Chhewang Sherpa",
                    designation: "President",
                  ),
                  MembersWidget(
                    isHeadMember: true,
                    name: "Bijay Gautam",
                    designation: "Vise President",
                  ),
                  MembersWidget(
                    isHeadMember: true,
                    name: "Mohammad Mustafa",
                    designation: "Secretary",
                  ),
                  MembersWidget(
                    isHeadMember: true,
                    name: "Avinash ",
                    designation: "Treasurer",
                  ),
                  SizedBox(height: 20),
                  Container(
                      alignment: Alignment.center,
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.withOpacity(0.5),
                      ),
                      child: Text("Club Members", style: AppStyles.kBB20)),
                  SizedBox(height: 10),
                  clubDetails == null
                      ? SizedBox() 
                      : clubDetails!.members == null ? SizedBox() : ListView.builder(
                          controller: _scrollController,
                          shrinkWrap: true,
                          itemCount: clubDetails!.members!.isNotEmpty
                              ? clubDetails!.members!.length - 1
                              : 0,
                          itemBuilder: (context, index) {
                            return MembersWidget(
                              isHeadMember: false,
                              name: clubDetails!.members![index + 1].name ?? "",
                              designation: "President",
                            );
                          }),
                ],
              ),
            ),
          );
          */
