import 'package:flutter/material.dart';

class BusinessStickeyHeader extends SliverPersistentHeaderDelegate {
  final int selectedTab;
  BusinessStickeyHeader(this.selectedTab);
  final headers = [
    'Description',
    'Business Info',
    'Listing Features',
    'Gallery'
  ];
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        height: 40,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: headers
                  .map(
                    (e) => Container(
                      alignment: Alignment.center,
                      height: 40,
                      margin: const EdgeInsets.only(right: 18),
                      decoration: BoxDecoration(
                        border: headers.indexOf(e) == selectedTab
                            ? Border(
                                bottom: BorderSide(color: Color(0xff1D4781)))
                            : null,
                      ),
                      child: Text(
                        e,
                        style: TextStyle(
                          color: headers.indexOf(e) == selectedTab
                              ? Color(0xff1D4781)
                              : Color(0xFF787878),
                          fontSize: 12,
                          fontFamily: 'Barlow',
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => 40;

  @override
  // TODO: implement minExtent
  double get minExtent => 40;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
