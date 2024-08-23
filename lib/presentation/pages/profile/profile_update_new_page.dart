import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rotary/core/resources/app_strings.dart';
import 'package:rotary/presentation/common_widgets/custom_textfield.dart';

class ProfileUpdateNewPage extends StatefulWidget {
  const ProfileUpdateNewPage({Key? key}) : super(key: key);

  @override
  State<ProfileUpdateNewPage> createState() => _ProfileUpdateNewPageState();
}

class _ProfileUpdateNewPageState extends State<ProfileUpdateNewPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  final GlobalKey personalCardKey = GlobalKey();
  final GlobalKey rotaryCardKey = GlobalKey();
  final GlobalKey businessCardKey = GlobalKey();
  final GlobalKey loginCardKey = GlobalKey();

  @override
  void initState() {
    tabController = TabController(length: 4, vsync: this, initialIndex: 0);
    tabController.addListener(() {
      //change the tab according to current cardkey
      
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_new_outlined, color: Colors.black)),
        title: const Text(
          'Update Information',
          style: TextStyle(
              fontFamily: "medium",
              color: Colors.black,
              fontWeight: FontWeight.w500),
        ),
        bottom: TabBar(
          controller: tabController,
          labelColor: Colors.black,
          labelStyle: const TextStyle(
              letterSpacing: 0.3, fontSize: 15, fontWeight: FontWeight.w500),
          indicatorSize: TabBarIndicatorSize.label,
          indicatorWeight: 5,
          isScrollable: true,
          onTap: (value) {
            switch (value) {
              case 0:
                Scrollable.ensureVisible(personalCardKey.currentContext!,
                    duration: const Duration(milliseconds: 500));

                break;
              case 1:
                Scrollable.ensureVisible(rotaryCardKey.currentContext!,
                    duration: const Duration(milliseconds: 500));
                break;
              case 2:
                Scrollable.ensureVisible(businessCardKey.currentContext!,
                    duration: const Duration(milliseconds: 500));
                break;
              case 3:
                Scrollable.ensureVisible(loginCardKey.currentContext!,
                    duration: const Duration(milliseconds: 500));
                break;
            }
          },
          tabs: [
            Tab(
              text: "Personal Profile",
            ),
            Tab(
              text: "Rotary Engagement",
            ),
            Tab(
              text: "Business Profile",
            ),
            Tab(
              text: "Login Info",
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: Column(
            children: [
              Column(
                key: personalCardKey,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              blurRadius: 4,
                            ),
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Personal Profile",
                              style: TextStyle(
                                  letterSpacing: .4,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            buildDropDown("- - Select Prefix - -"),
                            SizedBox(
                              height: 20,
                            ),
                            CustomTextField(
                              labelText: "First Name",
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            CustomTextField(
                              labelText: "Middle Name",
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            CustomTextField(
                              labelText: "Last Name",
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            CustomTextField(
                              labelText: "Address",
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            CustomTextField(
                              labelText: "Contact",
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            uploadButton("Click to upload photo"),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: double.infinity,
                              child: ElevatedButton(
                                  onPressed: () {},
                                  style: ButtonStyle(
                                      fixedSize: MaterialStateProperty.all(
                                          Size(double.infinity, 50)),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              AppColors.rotaryBlue)),
                                  child: Text(
                                    "Update",
                                    style: TextStyle(
                                        letterSpacing: .2,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
              Column(
                key: rotaryCardKey,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              blurRadius: 4,
                            ),
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Rotary Engagement",
                              style: TextStyle(
                                  letterSpacing: .4,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Location Details",
                              style: TextStyle(
                                  letterSpacing: .4,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            CustomTextField(
                              labelText: "City",
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            CustomTextField(
                              labelText: "Postal Code",
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Classification",
                              style: TextStyle(
                                  letterSpacing: .4,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            buildDropDown("- - Select Classification - -"),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Donor Type",
                              style: TextStyle(
                                  letterSpacing: .4,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            buildDropDown("- - Select Donor Type - -"),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Club and Country",
                              style: TextStyle(
                                  letterSpacing: .4,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            buildDropDown("- - Select Club - -"),
                            SizedBox(
                              height: 20,
                            ),
                            buildDropDown("- - Select Country - -"),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: double.infinity,
                              child: ElevatedButton(
                                  onPressed: () {},
                                  style: ButtonStyle(
                                      fixedSize: MaterialStateProperty.all(
                                          Size(double.infinity, 50)),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              AppColors.rotaryBlue)),
                                  child: Text(
                                    "Update",
                                    style: TextStyle(
                                        letterSpacing: .2,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
              Column(
                key: businessCardKey,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              blurRadius: 4,
                            ),
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Business Profile",
                              style: TextStyle(
                                  letterSpacing: .4,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: AppColors.rotaryBlue.withOpacity(.1),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Row(
                                  children: [
                                    Text(
                                      "Are you willing to list your business?",
                                      style: TextStyle(
                                          letterSpacing: .1,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Spacer(),
                                    Row(
                                      children: [
                                        Text(
                                          "No",
                                          style: TextStyle(
                                              letterSpacing: .1,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Container(
                                          width: 50,
                                          child: Switch(
                                            materialTapTargetSize:
                                                MaterialTapTargetSize
                                                    .shrinkWrap,
                                            value: true,
                                            onChanged: (value) {},
                                            activeColor: AppColors.rotaryBlue,
                                            inactiveThumbColor: Colors.white,
                                            inactiveTrackColor:
                                                Colors.grey[400],
                                          ),
                                        ),
                                        Text(
                                          "Yes",
                                          style: TextStyle(
                                              letterSpacing: .1,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Business Details",
                              style: TextStyle(
                                  letterSpacing: .4,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            CustomTextField(
                              labelText: "Business Name",
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            CustomTextField(
                              labelText: "Business Address",
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            CustomTextField(
                              labelText: "Business Email",
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            CustomTextField(
                              labelText: "Business Phone",
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            uploadButton("Click to upload Business Logo"),
                            SizedBox(
                              height: 20,
                            ),
                            CustomTextField(
                              labelText: "Business Url",
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            CustomTextField(
                              hintText: "Business Description",
                              maxLines: 6,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            CustomTextField(
                              hintText: "Small Slogan",
                              maxLines: 4,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Business Social Media Links",
                              style: TextStyle(
                                  letterSpacing: .4,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            CustomTextField(
                              hintText: "Facebook URL",
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            CustomTextField(
                              hintText: "Instagram URL",
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            CustomTextField(
                              hintText: "Linkedin URL",
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            CustomTextField(
                              hintText: "Twitter URL",
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Business Features List",
                                  style: TextStyle(
                                      letterSpacing: .4,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                Spacer(),
                                chipBuilder("Add Feature")
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            CustomTextField(
                              hintText: "Feature Title",
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            uploadButton("Click to upload Feature Image"),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              height: 40,
                              width: double.infinity,
                              child: ElevatedButton(
                                  onPressed: () {},
                                  style: ButtonStyle(
                                      fixedSize: MaterialStateProperty.all(
                                          Size(double.infinity, 50)),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.red[900])),
                                  child: Text(
                                    "Remove",
                                    style: TextStyle(
                                        letterSpacing: .2,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Business Hours",
                              style: TextStyle(
                                  letterSpacing: .4,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            hoursBuilder("Sun", true),
                            SizedBox(
                              height: 10,
                            ),
                            hoursBuilder("Mon", false),
                            SizedBox(
                              height: 10,
                            ),
                            hoursBuilder("Tue", false),
                            SizedBox(
                              height: 10,
                            ),
                            hoursBuilder("Wed", false),
                            SizedBox(
                              height: 10,
                            ),
                            hoursBuilder("Thu", false),
                            SizedBox(
                              height: 10,
                            ),
                            hoursBuilder("Fri", false),
                            SizedBox(
                              height: 10,
                            ),
                            hoursBuilder("Sat", true),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Business Gallery",
                                  style: TextStyle(
                                      letterSpacing: .4,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                Spacer(),
                                chipBuilder("Add Gallery")
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            CustomTextField(
                              hintText: "Image Title",
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            uploadButton("Click to upload Image"),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              height: 40,
                              width: double.infinity,
                              child: ElevatedButton(
                                  onPressed: () {},
                                  style: ButtonStyle(
                                      fixedSize: MaterialStateProperty.all(
                                          Size(double.infinity, 50)),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.red[900])),
                                  child: Text(
                                    "Remove",
                                    style: TextStyle(
                                        letterSpacing: .2,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: double.infinity,
                              child: ElevatedButton(
                                  onPressed: () {},
                                  style: ButtonStyle(
                                      fixedSize: MaterialStateProperty.all(
                                          Size(double.infinity, 50)),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              AppColors.rotaryBlue)),
                                  child: Text(
                                    "Update",
                                    style: TextStyle(
                                        letterSpacing: .2,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
              Column(
                key: loginCardKey,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              blurRadius: 4,
                            ),
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Login Info",
                              style: TextStyle(
                                  letterSpacing: .4,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Login Details",
                              style: TextStyle(
                                  letterSpacing: .4,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            CustomTextField(
                              labelText: "Email Address",
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Current Password",
                              style: TextStyle(
                                  letterSpacing: .4,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            CustomTextField(
                              hintText: "Current Password",
                              isObsecure: true,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "New Password",
                              style: TextStyle(
                                  letterSpacing: .4,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            CustomTextField(
                              hintText: "New Password",
                              isObsecure: true,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Confirm Password",
                              style: TextStyle(
                                  letterSpacing: .4,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            CustomTextField(
                              hintText: "Confirm Password",
                              isObsecure: true,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: double.infinity,
                              child: ElevatedButton(
                                  onPressed: () {},
                                  style: ButtonStyle(
                                      fixedSize: MaterialStateProperty.all(
                                          Size(double.infinity, 50)),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              AppColors.rotaryBlue)),
                                  child: Text(
                                    "Update",
                                    style: TextStyle(
                                        letterSpacing: .2,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<String> dropDownList = [
  "Hello",
  "Good Morning",
  "Prasanna",
  "Good Afternoon",
  "Good Evening",
  "Good Night"
];

Widget buildDropDown(String hintText) {
  return Container(
    height: 45,
    padding: EdgeInsets.symmetric(horizontal: 10),
    decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[400]!),
        borderRadius: BorderRadius.circular(4)),
    child: DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        isExpanded: true,
        hint: Text(
          hintText,
          style: TextStyle(fontSize: 13, color: Colors.grey[800]),
        ),
        onChanged: (String? newValue) {},
        items: dropDownList.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            ),
          );
        }).toList(),
      ),
    ),
  );
}

Widget uploadButton(String name) {
  return Container(
    height: 120,
    width: 160,
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
    child: DottedBorder(
      color: Colors.grey[600]!,
      strokeWidth: 1,
      dashPattern: [5, 5],
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/images/svg/upload.svg",
                height: 30,
                width: 30,
              ),
              SizedBox(
                height: 5,
              ),
              Center(
                child: Text(
                  name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[800],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}

Widget chipBuilder(String name) {
  return Container(
    decoration: BoxDecoration(
        color: AppColors.rotaryBlue, borderRadius: BorderRadius.circular(10)),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        children: [
          Icon(
            Icons.add,
            color: Colors.white,
          ),
          Text(
            " ${name}",
            style: TextStyle(
                letterSpacing: .1,
                fontSize: 12,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ),
  );
}

Widget hoursBuilder(String name, bool isClosed) {
  return Row(
    children: [
      Container(
        width: 40,
        child: Text(
          name,
          style: TextStyle(
              letterSpacing: .1,
              fontSize: 14,
              color: Colors.grey[800],
              fontWeight: FontWeight.bold),
        ),
      ),
      SizedBox(
        width: 10,
      ),
      Container(
        width: 50,
        child: Switch(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          value: !isClosed,
          onChanged: (value) {},
          activeColor: AppColors.rotaryBlue,
          inactiveThumbColor: Colors.white,
          inactiveTrackColor: Colors.grey[400],
        ),
      ),
      SizedBox(
        width: 10,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Text(
          isClosed ? "Closed" : "Open",
          style: TextStyle(
              letterSpacing: .1,
              fontSize: 12,
              color: isClosed ? Colors.red[900] : Colors.green,
              fontWeight: FontWeight.bold),
        ),
      ),
      SizedBox(
        width: 10,
      ),
      !isClosed
          ? Expanded(
              child: CustomTextField(
                hintText: "Open and Close Time",
              ),
            )
          : Container(),
    ],
  );
}
