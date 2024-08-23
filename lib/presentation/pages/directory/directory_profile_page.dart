import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rotary/core/resources/app_strings.dart';
import 'package:rotary/data/models/business_directory/user.dart';
import 'package:rotary/presentation/pages/calender_page/utils.dart';

import '../../common_widgets/custom_textfield.dart';

class DirectoryProfilePage extends StatefulWidget {
  final User user;
  const DirectoryProfilePage({Key? key, required this.user}) : super(key: key);

  @override
  State<DirectoryProfilePage> createState() => _DirectoryProfilePageState();
}

class _DirectoryProfilePageState extends State<DirectoryProfilePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 350,
              decoration: BoxDecoration(
                color: AppColors.rotaryBlue,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  colorFilter: new ColorFilter.mode(
                    Colors.black.withOpacity(0.3),
                    BlendMode.darken,
                  ),
                  image: CachedNetworkImageProvider(
                      widget.user.userDetails?.image ?? ""),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(bottom: 40, left: 25, right: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SafeArea(
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.white.withOpacity(0.7),
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${widget.user.firstname ?? ""} ${widget.user.middlename ?? ""} ${widget.user.lastname ?? ""}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontFamily: 'medium',
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      widget.user.classification ?? "",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    widget.user.clubUser == null
                        ? SizedBox()
                        : Text(
                            'Rotary Club of ${widget.user.clubUser!.name ?? ""}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 320),
              child: Container(
                  // height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                  ),
                  child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(children: [
                        widget.user.donorType != null
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    " Donor Type",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Card(
                                    elevation: 0,
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  widget.user.donorType ??
                                                      'Not Available',
                                                  style:
                                                      TextStyle(fontSize: 22)),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : SizedBox(),
                        (widget.user.address != null ||
                                widget.user.phoneNo != null ||
                                widget.user.email != null)
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    " Contact",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Card(
                                      elevation: 0,
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            widget.user.address != null
                                                ? Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 3),
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          flex: 2,
                                                          child: Text(
                                                            "Address",
                                                            style: TextStyle(
                                                                fontSize: 12),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 4,
                                                          child: Text(
                                                            widget.user
                                                                    .address ??
                                                                "",
                                                            style: TextStyle(
                                                                fontSize: 12),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                : SizedBox(),
                                            widget.user.phoneNo != null
                                                ? Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 3),
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          flex: 2,
                                                          child: Text(
                                                            "Phone",
                                                            style: TextStyle(
                                                                fontSize: 12),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 4,
                                                          child: Text(
                                                            widget.user
                                                                    .phoneNo ??
                                                                "",
                                                            style: TextStyle(
                                                                fontSize: 12),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                : SizedBox(),
                                            widget.user.email != null
                                                ? Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 3),
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          flex: 2,
                                                          child: Text(
                                                            "Email",
                                                            style: TextStyle(
                                                                fontSize: 12),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 4,
                                                          child: Text(
                                                            widget.user.email ??
                                                                "",
                                                            style: TextStyle(
                                                                fontSize: 12),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                : SizedBox(),
                                          ],
                                        ),
                                      )),
                                ],
                              )
                            : SizedBox(),
                        widget.user.bio != null
                            ? Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      " Bio",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Card(
                                        elevation: 0,
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(widget.user.bio ?? "",
                                                  style:
                                                      TextStyle(fontSize: 13)),
                                            ],
                                          ),
                                        )),
                                  ],
                                ),
                              )
                            : SizedBox(),
                        widget.user.userClubRoles != null &&
                                widget.user.userClubRoles!.isNotEmpty
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    " Club Roles",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Card(
                                    elevation: 0,
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          ListView.separated(
                                            physics: ClampingScrollPhysics(),
                                            padding: EdgeInsets.zero,
                                            shrinkWrap: true,
                                            itemCount: widget
                                                .user.userClubRoles!.length,
                                            separatorBuilder:
                                                (context, index) =>
                                                    const SizedBox(
                                              height: 2,
                                            ),
                                            itemBuilder: (context, index) =>
                                                Row(
                                              children: [
                                                Text(
                                                  "\u2022 ",
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                ),
                                                Flexible(
                                                  child: Text(
                                                      "${(widget.user.userClubRoles![index].role ?? "").capitalizeFirst()}  (${widget.user.userClubRoles![index].activeFrom == null ? "" : widget.user.userClubRoles![index].activeFrom.toString().split(" ")[0]}${widget.user.userClubRoles![index].activeTo == null ? "" : "  to  " + widget.user.userClubRoles![index].activeTo.toString().split(" ")[0]})",
                                                      style: TextStyle(
                                                          fontSize: 13)),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : SizedBox(),
                        const SizedBox(
                          height: 5,
                        ),
                        widget.user.userDistrictCommittee != null &&
                                widget.user.userDistrictCommittee!.isNotEmpty
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    " District Roles",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Card(
                                    elevation: 0,
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          ListView.separated(
                                            physics: ClampingScrollPhysics(),
                                            padding: EdgeInsets.zero,
                                            shrinkWrap: true,
                                            itemCount: widget.user
                                                .userDistrictCommittee!.length,
                                            separatorBuilder:
                                                (context, index) =>
                                                    const SizedBox(
                                              height: 2,
                                            ),
                                            itemBuilder: (context, index) =>
                                                Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "\u2022 ",
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                ),
                                                Flexible(
                                                  child: Text(
                                                    "${(widget.user.userDistrictCommittee![index].role ?? "").capitalizeFirst()}",
                                                    style:
                                                        TextStyle(fontSize: 13),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : SizedBox(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              " Get in touch",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Card(
                              elevation: 0,
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomTextField(
                                      hintText: "Name",
                                      labelText: "Name",
                                      borderColor: Colors.black,
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    CustomTextField(
                                      hintText: "Email",
                                      labelText: "Email",
                                      borderColor: Colors.black,
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    CustomTextField(
                                      hintText: "Message",
                                      borderColor: Colors.black,
                                      maxLines: 5,
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Container(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                          onPressed: () {},
                                          style: ButtonStyle(
                                              fixedSize:
                                                  MaterialStateProperty.all(
                                                      Size(
                                                          double.infinity, 50)),
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Color(0xffa60000))),
                                          child: Text("Send Message")),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      ]))),
            )
          ],
        ),
      )),
    );
  }
}

class CardModel {
  final String title;
  final String desc;

  CardModel({required this.title, required this.desc});
}

class MyBullet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      decoration: new BoxDecoration(
        color: Colors.black,
        shape: BoxShape.circle,
      ),
    );
  }
}
