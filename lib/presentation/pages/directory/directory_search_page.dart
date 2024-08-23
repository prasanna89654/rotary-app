import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rotary/core/resources/app_strings.dart';
import 'package:rotary/data/models/business_directory/business_directory.dart';
import 'package:rotary/presentation/pages/directory/directory_detail_page.dart';

class DirectorySearchPage extends StatefulWidget {
  final List<BusinessDirectory> classifications;
  const DirectorySearchPage({Key? key, required this.classifications})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _DirectorySearchPageState();
}

class _DirectorySearchPageState extends State<DirectorySearchPage> {
  @override
  void initState() {
    super.initState();
    searchedDirectories = widget.classifications;
  }

  bool isOverlay = true;

  late List<BusinessDirectory> searchedDirectories;

  searchDirectory(String searchText) {
    searchedDirectories = [];
    widget.classifications.forEach((directory) {
      if (directory.name!.toLowerCase().contains(searchText.toLowerCase())) {
        searchedDirectories.add(directory);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[100]!,
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: TextFormField(
                  onTap: () {
                    setState(() {
                      isOverlay = true;
                    });
                  },
                  onChanged: (value) {
                    setState(() {
                      searchDirectory(value);
                      // widget.classifications = names
                      //     .where((element) => element.name
                      //         .toLowerCase()
                      //         .contains(value.toLowerCase()))
                      //     .toList();
                    });
                  },
                  decoration: InputDecoration(
                    prefixIcon: IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    hintText: 'Search directory name...',
                    hintStyle: TextStyle(
                      fontSize: 16,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(10),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Visibility(
                  visible: isOverlay,
                  child: ListView.separated(
                      separatorBuilder: (context, index) => Divider(
                            color: Colors.grey[300],
                          ),
                      itemCount: searchedDirectories.length > 15
                          ? 15
                          : searchedDirectories.length,
                      shrinkWrap: true,
                      // physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return FadeInRight(
                          delay: Duration(milliseconds: 50 * index),
                          duration: const Duration(milliseconds: 300),
                          child: InkWell(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DirectoryDetailPage(
                                          directoryUser:
                                              searchedDirectories[index]
                                                      .users ??
                                                  [],
                                          directoryTitle:
                                              searchedDirectories[index].name ??
                                                  "")));
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 3.0),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    SvgPicture.network(
                                      searchedDirectories[index].imageUrl ?? "",
                                      height: 30,
                                      width: 30,
                                      placeholderBuilder: (context) => Icon(
                                        Icons.info,
                                        color: AppColors.rotaryBlue,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      searchedDirectories[index].name ?? "",
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontFamily: 'thin',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<OptionsModel> names = [
  // "Bars",
  // "Burgers",
  // "Cafe",
  // "Restaurants",
  // "Grocery",

  OptionsModel(name: "Bars", icon: Icons.bar_chart),
  OptionsModel(name: "Burgers", icon: Icons.fastfood),
  OptionsModel(name: "Cafe", icon: Icons.coffee),
  OptionsModel(name: "Restaurants", icon: Icons.restaurant),
  OptionsModel(name: "Grocery", icon: Icons.shopping_cart),
];

class OptionsModel {
  String name;
  IconData icon;

  OptionsModel({required this.name, required this.icon});
}

     // const SizedBox(height: 10),
                      // Container(
                      //   width: MediaQuery.of(context).size.width,
                      //   decoration: BoxDecoration(
                      //     color: Colors.white,
                      //     borderRadius: BorderRadius.circular(10),
                      //     border: Border.all(color: Colors.grey[300]!),
                      //   ),
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(12.0),
                      //     child: Row(
                      //       children: [
                      //         Icon(
                      //           Icons.location_on_outlined,
                      //           color: Colors.blue[400]!,
                      //         ),
                      //         const SizedBox(width: 10),
                      //         Text(
                      //           'Current Location',
                      //           style: TextStyle(
                      //             fontSize: 16,
                      //             color: Colors.blue[400]!,
                      //             fontFamily: 'medium',
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
