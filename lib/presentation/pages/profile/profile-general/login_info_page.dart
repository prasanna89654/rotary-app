import 'package:flutter/material.dart';

import '../../../../core/resources/app_strings.dart';
import '../../../common_widgets/custom_textfield.dart';

class LoginInfoPage extends StatelessWidget {
  const LoginInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login Info')),
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
        ),
      ),
    );
  }
}
