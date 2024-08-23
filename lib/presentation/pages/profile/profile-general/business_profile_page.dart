import 'package:flutter/material.dart';

import '../../../../core/resources/app_strings.dart';
import '../../../common_widgets/custom_textfield.dart';
import '../profile_update_new_page.dart';

class BusinessProfilePage extends StatelessWidget {
  const BusinessProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Business Profile')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: Column(
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
                                            MaterialTapTargetSize.shrinkWrap,
                                        value: true,
                                        onChanged: (value) {},
                                        activeColor: AppColors.rotaryBlue,
                                        inactiveThumbColor: Colors.white,
                                        inactiveTrackColor: Colors.grey[400],
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
                                  backgroundColor: MaterialStateProperty.all(
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
                                  backgroundColor: MaterialStateProperty.all(
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
                                  backgroundColor: MaterialStateProperty.all(
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
        ),
      ),
    );
  }
}
