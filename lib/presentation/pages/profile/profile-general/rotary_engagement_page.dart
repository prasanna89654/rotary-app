import 'package:flutter/material.dart';

import '../../../../core/resources/app_strings.dart';
import '../../../common_widgets/custom_textfield.dart';
import '../profile_update_new_page.dart';

class RotaryEngagementPage extends StatelessWidget {
  const RotaryEngagementPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rotary Engagement')),
      body:  SingleChildScrollView(
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
        ),
      ),
    );
  }
}
