// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:flutter/material.dart';
// import 'package:rotary/core/resources/app_strings.dart';
// import 'package:rotary/core/resources/app_styles.dart';
// import 'package:rotary/domain/entities/home/home_entities/dg.dart';

// class DGMessageView extends StatelessWidget {
//   final Dg dg;
//   const DGMessageView({Key? key, required this.dg}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('DG View'),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 width: MediaQuery.of(context).size.width,
//                 height: MediaQuery.of(context).size.width,
//                 color: Colors.grey,
//               ),
//               SizedBox(height: 10),
//               Container(
//                 alignment: Alignment.center,
//                 width: double.infinity,
//                 height: 50,
//                 decoration: BoxDecoration(
//                   border: Border.all(
//                     color: AppColors.rotaryGold,
//                     width: 2,
//                   ),
//                 ),
//                 child: AutoSizeText(
//                   "Bio Data of District Governer".toUpperCase(),
//                   textAlign: TextAlign.center,
//                   style: AppStyles.kBB18,
//                 ),
//               ),
//               SizedBox(height: 20),
//               Text(dg.dgView.toString(), style: AppStyles.kBB20),
//               SizedBox(height: 10),
//               Text(dg.activeYear.toString(), style: AppStyles.kB16),
//               SizedBox(height: 20),
//               Text(
//                 dg.description.toString(),
//                 textAlign: TextAlign.justify,
//               ),
//               // Container(
//               //   width: MediaQuery.of(context).size.width,
//               //   height: MediaQuery.of(context).size.width,
//               //   color: Colors.grey,
//               // )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
