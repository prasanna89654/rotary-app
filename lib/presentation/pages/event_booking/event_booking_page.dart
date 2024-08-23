import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:rotary/core/resources/app_styles.dart';

import '../../../core/resources/app_strings.dart';

class EventBookingPage extends StatelessWidget {
  const EventBookingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              colorFilter: new ColorFilter.mode(
                Colors.black.withOpacity(0.2),
                BlendMode.darken,
              ),
              image: AssetImage("assets/images/menu_background.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AutoSizeText(
                  "Event Title",
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge!
                      .copyWith(color: AppColors.rotaryGold),
                ),
                SizedBox(
                  height: 10,
                ),
                AutoSizeText("JAN-21-2023" + " TO " + "JAN-21-2023",
                    style: AppStyles.kB16.copyWith(color: Colors.white)),
                SizedBox(
                  height: 50,
                ),
                AutoSizeText(
                  "Registration charge includes high tea & cocktail dinner on the date and lunch on the date. Please Fill up the registration form to confirm your participation by date \n For more information please contact district secretary Rtn. Dinesh Raj Manandhar",
                  style: AppStyles.kB16.copyWith(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 50,
                ),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 60,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all(
                                Size(double.infinity, 60)),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white),
                            foregroundColor:
                                MaterialStateProperty.all(Colors.black),
                          ),
                          child: Text(
                            "Click Here To Register",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 60,
                        child: OutlinedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all(
                                Size(double.infinity, 60)),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white),
                            foregroundColor:
                                MaterialStateProperty.all(Colors.black),
                          ),
                          child: Text(
                            "Click Here To Book Your Hotel",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
