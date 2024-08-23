import 'package:flutter/material.dart';
import 'package:rotary/core/resources/app_strings.dart';
import 'package:rotary/core/resources/app_styles.dart';
import 'package:rotary/presentation/pages/profile/profile.dart';
import 'package:rotary/presentation/pages/rotary_info.dart';
import 'package:url_launcher/url_launcher.dart';


class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 220,
            decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(color: AppColors.BorderColor)),
                image: DecorationImage(
                    image: AssetImage("assets/images/logo.png"),
                    fit: BoxFit.contain)),
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ExpansionTile(
                  //   title: Text("DG Section"),
                  //   children: <Widget>[
                  //     ListTile(
                  //       title: Text("BIO of DG"),
                  //     ),
                  //     ListTile(
                  //       title: Text("Guidelines for DG Club Visit"),
                  //     ),
                  //     ListTile(
                  //       title: Text("Checklists for DG club visit"),
                  //     ),
                  //   ],
                  // ),
                  // ListTile(
                  //   title: Text("Rotary Info"),
                  //   onTap: () {},
                  // ),
                  // ListTile(
                  //   title: Text("District Info"),
                  //   onTap: () {},
                  // ),
                  ListTile(
                      title: Row(
                        children: [
                          Container(
                            width: 30,
                            height: 2,
                            decoration: BoxDecoration(color: Colors.grey),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Rotary District 3292".toUpperCase(),
                            style: AppStyles.kBB14,
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RotaryInfoPage()));
                      }),
                  // ListTile(
                  //   title: Row(
                  //     children: [
                  //       Container(
                  //         width: 30,
                  //         height: 2,
                  //         decoration: BoxDecoration(color: Colors.grey),
                  //       ),
                  //       SizedBox(
                  //         width: 10,
                  //       ),
                  //       Text(
                  //         "GML".toUpperCase(),
                  //         style: AppStyles.kBB14,
                  //       ),
                  //     ],
                  //   ),
                  //   onTap: () {
                  //     Navigator.pop(context);
                  //     Navigator.push(context,
                  //         MaterialPageRoute(builder: (context) => GMLPage()));
                  //   },
                  // ),
                  // ListTile(
                  //   title: Row(
                  //     children: [
                  //       Container(
                  //         width: 30,
                  //         height: 2,
                  //         decoration: BoxDecoration(color: Colors.grey),
                  //       ),
                  //       SizedBox(
                  //         width: 10,
                  //       ),
                  //       Text(
                  //         "IT Team".toUpperCase(),
                  //         style: AppStyles.kBB14,
                  //       ),
                  //     ],
                  //   ),
                  //   onTap: () {
                  //     Navigator.pop(context);
                  //     Navigator.of(context).push(MaterialPageRoute(
                  //         builder: (context) => ITTeamPage()));
                  //   },
                  // ),
                  // ListTile(
                  //   title: Row(
                  //     children: [
                  //       Container(
                  //         width: 30,
                  //         height: 2,
                  //         decoration: BoxDecoration(color: Colors.grey),
                  //       ),
                  //       SizedBox(
                  //         width: 10,
                  //       ),
                  //       Text(
                  //         "DG Calendar".toUpperCase(),
                  //         style: AppStyles.kBB14,
                  //       ),
                  //     ],
                  //   ),
                  //   onTap: () {
                  //     Navigator.pop(context);
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: (context) => DgNewCalendar()),
                  //     );
                  //   },
                  // ),
                  ListTile(
                    title: Row(
                      children: [
                        Container(
                          width: 30,
                          height: 2,
                          decoration: BoxDecoration(color: Colors.grey),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Profile".toUpperCase(),
                          style: AppStyles.kBB14,
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfilePage(
                            isLoggedIn: false,
                          ),
                        ),
                      );
                    },
                  ),
                  // ListTile(
                  //   title: Row(
                  //     children: [
                  //       Container(
                  //         width: 30,
                  //         height: 2,
                  //         decoration: BoxDecoration(color: Colors.grey),
                  //       ),
                  //       SizedBox(
                  //         width: 10,
                  //       ),
                  //       Text(
                  //         "Event Booking".toUpperCase(),
                  //         style: AppStyles.kBB14,
                  //       ),
                  //     ],
                  //   ),
                  //   onTap: () {
                  //     Navigator.pop(context);
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) => EventBookingPage()
                  //       ),
                  //     );
                  //   },
                  // ),

                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Contact Info".toUpperCase(),
                          style: AppStyles.kBB14.copyWith(
                            color: AppColors.rotaryBlue,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        _clubInfoWidget(
                          icon: Icons.location_on,
                          title: "Address:",
                          text1: "Rotary Bhawan, thapathali",
                          text2: "Kathmandu, Nepal",
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () async {
                            final url = Uri(scheme: "tel", path: "014255344");
                            bool _canlaunch = await canLaunchUrl(url);
                            if (_canlaunch) {
                              launchUrl(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                          child: _clubInfoWidget(
                              icon: Icons.phone,
                              title: "Phone:",
                              text1: "014255344",
                              text1OnTap: () async {
                                final url =
                                    Uri(scheme: "tel", path: "014255344");
                                bool _canlaunch = await canLaunchUrl(url);
                                if (_canlaunch) {
                                  launchUrl(url);
                                } else {
                                  throw 'Could not launch $url';
                                }
                              }),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () async {
                            final url = Uri(
                                scheme: "mailto", path: "rotary@ntc.net.np");
                            bool _canlaunch = await canLaunchUrl(url);
                            if (_canlaunch) {
                              launchUrl(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                          child: _clubInfoWidget(
                              icon: Icons.email,
                              title: "Email:",
                              text1: "rotary@ntc.net.np",
                              text1OnTap: () async {
                                final url = Uri(
                                    scheme: "mailto",
                                    path: "rotary@ntc.net.np");
                                bool _canlaunch = await canLaunchUrl(url);
                                if (_canlaunch) {
                                  launchUrl(url);
                                } else {
                                  throw 'Could not launch $url';
                                }
                              }),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Row _clubInfoWidget(
      {required IconData icon,
      required String title,
      required String text1,
      Function()? text1OnTap,
      String? text2}) {
    return Row(
      children: [
        Container(
          width: 60,
          height: 50,
          decoration:
              BoxDecoration(border: Border.all(color: AppColors.royalBlue)),
          child: Icon(
            icon,
            color: AppColors.rotaryGold,
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: AppStyles.kBB12,
            ),
            InkWell(
              onTap: text1OnTap,
              child: Text(
                text1,
                // "Totary Bhawan, thapathali",
                style: AppStyles.kB12,
              ),
            ),
            text2 == null
                ? SizedBox()
                : Text(
                    text2,
                    // "Kathmandu, Nepal",
                    style: AppStyles.kB12,
                  )
          ],
        )
      ],
    );
  }
}

class MenuItem extends StatelessWidget {
  final String title;
  final Function()? onTap;

  const MenuItem({Key? key, required this.title, this.onTap}) : super(key: key);
  @override
  Widget build(context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 50,
        child: Text(title),
      ),
    );
  }
}
