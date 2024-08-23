import 'package:flutter/material.dart';

import '../../../../core/resources/app_strings.dart';
import '../../../common_widgets/custom_textfield.dart';
import '../profile_update_new_page.dart';

class PersonalProfilePage extends StatelessWidget {
  const PersonalProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Personal Profile')),
      body:   SingleChildScrollView(
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
        ),
      ),
    );
  }
}
