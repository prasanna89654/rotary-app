
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rotary/core/resources/app_strings.dart';
import 'package:rotary/core/resources/app_styles.dart';
import 'package:rotary/presentation/pages/gml/document_viewer.dart';

import '../../features/gml_bloc/gml_bloc.dart';

class GMLPage extends StatelessWidget {
  const GMLPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackgroundColor,
      appBar: AppBar(
        title: Text("GML"),
      ),
      body: GMLPageBody(),
    );
  }
}

class GMLPageBody extends StatefulWidget {
  const GMLPageBody({Key? key}) : super(key: key);

  @override
  State<GMLPageBody> createState() => _GMLPageBodyState();
}

class _GMLPageBodyState extends State<GMLPageBody>
    with TickerProviderStateMixin {
  int selectedGML = 0;
  Color selectedColor = AppColors.rotaryBlue;
  late AnimationController _controller;
  late AnimationController _fadeAnimController;
  late Animation<Offset> _animation;
  late Animation _animationTween;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation = Tween<Offset>(
      begin: const Offset(1, 0),
      end: const Offset(0.0, 0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );
    _animationTween = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _fadeAnimController,
        curve: Curves.easeIn,
      ),
    );

    _controller.forward();
    _fadeAnimController.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _fadeAnimController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GmlBloc, GmlState>(
      listener: (context, state) {
        // if (state is GmlLoaded) {
        //   Future.delayed(Duration(milliseconds: 500), () {
        //     _controller.forward();
        //     _fadeAnimController.forward();
        //   });
        // }
      },
      builder: (context, state) {
        if (state is GmlInitial) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is GmlError) {
          return Center(
            child: Text(state.errorMessage),
          );
        }
        if (state is GmlLoaded) {
          List newList = state.gmlModel.reversed.toList();
          print(newList);
          return newList.length > 0
              ? Padding(
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Governor's Monthly Letter (GML)",
                        style: AppStyles.kBB16,
                      ),
                      SizedBox(height: 16),
                      FadeTransition(
                        opacity: _animationTween as Animation<double>,
                        child: SlideTransition(
                          position: _animation,
                          child: Container(
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                            ),
                            child: Text(
                              newList[selectedGML].title.toString(),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: newList.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () async {
                              _controller.reset();
                              _fadeAnimController.reset();

                              _controller.forward();
                              _fadeAnimController.forward();
                              setState(() {
                                selectedGML = index;
                              });
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DocumentViewer(
                                            filePath: newList[index].filename,
                                            title: newList[selectedGML]
                                                .title
                                                .toString(),
                                          )));

                              // bool canLaunch = await canLaunchUrl(
                              //     Uri.parse(newList[index].filename ?? ""));
                              // if (canLaunch) {
                              //   await launchUrl(
                              //       Uri.parse(newList[index].filename ?? ""),
                              //       mode: Platform.isAndroid
                              //           ? LaunchMode
                              //               .externalNonBrowserApplication
                              //           : LaunchMode.platformDefault);
                              // } else {
                              //   throw 'Could not launch ${newList[index].filename ?? ""}';
                              // }
                            },
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 200),
                              curve: Curves.easeInToLinear,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: index == selectedGML
                                    ? selectedColor
                                    : Colors.white,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xff59AE98)),
                                    child: Center(
                                      child: Text(
                                        "GML",
                                        style: AppStyles.kWB12,
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Text(
                                        newList[index]
                                            .month
                                            .toString()
                                            .substring(0, 3)
                                            .toUpperCase(),
                                        style: AppStyles.kWB12.copyWith(
                                            color: index == selectedGML
                                                ? Color(0xffDC9D52)
                                                : Color(0xff3B7890)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                )
              : SizedBox(
                  child: Center(
                    child: Text(
                      "No GML found",
                      style: AppStyles.kBB12,
                    ),
                  ),
                );
        }
        return Container();
      },
    );
  }
}
