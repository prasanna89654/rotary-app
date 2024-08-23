import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rotary/core/resources/app_styles.dart';
import 'package:rotary/data/models/home/home_model.dart';
import 'package:rotary/presentation/features/home_page_bloc/homepage_bloc.dart';

class RotaryInfoPage extends StatelessWidget {
  const RotaryInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeModel? homeModel = BlocProvider.of<HomepageBloc>(context).homeModel;
    return Scaffold(
      appBar: AppBar(
        title: Text('Rotary District 3292'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              "Welcome to Rotary International District 3292",
              style: AppStyles.kBB14,
              textAlign: TextAlign.justify,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              homeModel?.aboutRotatory ?? "",
              style: AppStyles.kB14,
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
