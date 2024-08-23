// import 'package:flutter/material.dart';
// import 'package:rotary/core/resources/app_constants.dart';
// import 'package:rotary/core/resources/app_strings.dart';

// import '../profile_page.dart';

// class MembersWidget extends StatelessWidget {
//   final String name;
//   final String designation;
//   final bool isHeadMember;

//   const MembersWidget(
//       {Key? key,
//       required this.name,
//       this.designation = "",
//       this.isHeadMember = false})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final double height = isHeadMember ? 100 : 60;

//     return InkWell(
//       onTap: () {
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => ProfilePage(
//                       isFromClub: true,
//                       name: name,
//                     )));
//       },
//       child: Padding(
//         padding: const EdgeInsets.only(bottom: 8.0),
//         child: Container(
//           height: height,
//           decoration: BoxDecoration(
//             border: Border.all(color: AppColors.BorderColor),
//             borderRadius: AppConstant.DefaultRadius,
//           ),
//           child: Row(
//             children: [
//               const SizedBox(width: 10),
//               Container(
//                 width: height * 0.8,
//                 height: height * 0.8,
//                 decoration:
//                     BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
//               ),
//               Expanded(
//                 child: Padding(
//                   padding: const EdgeInsets.all(8),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         name,
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       isHeadMember
//                           ? SizedBox(
//                               height: 5,
//                             )
//                           : SizedBox(),
//                       isHeadMember
//                           ? Text(
//                               designation,
//                               style: TextStyle(
//                                 fontSize: 14,
//                               ),
//                             )
//                           : SizedBox()
//                     ],
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
