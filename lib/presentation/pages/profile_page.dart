// import 'package:flutter/material.dart';
// import 'package:rotary/presentation/common_widgets/custom_appbar.dart';
// import 'package:rotary/presentation/common_widgets/drawer.dart';

// class ProfilePage extends StatelessWidget {
//   final bool isFromClub;
//   final String? name;
//   final String? designation;
//   const ProfilePage(
//       {Key? key, this.isFromClub = false, this.name, this.designation})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       drawer: !isFromClub ? DrawerWidget() : null,
//       appBar: isFromClub
//           ? AppBar(
//               title: Text('Profile'),
//             )
//           : null,
//       body: CustomScrollView(
//         slivers: [
//           !isFromClub ? CustomAppBar() : SliverToBoxAdapter(child: SizedBox()),
//           SliverToBoxAdapter(child: _buildBody()),
//         ],
//       ),
//     );
//   }

//   _buildBody() {
//     return Padding(
//       padding: const EdgeInsets.all(20),
//       child: Column(
//         children: <Widget>[
//           const SizedBox(
//             height: 20,
//           ),
//           Container(
//             width: 100,
//             height: 100,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               shape: BoxShape.circle,
//               border: Border.all(color: Colors.grey),
//               boxShadow: [
//                 BoxShadow(
//                   offset: const Offset(3, 6),
//                   color: Colors.grey.withOpacity(0.5),
//                   blurRadius: 12,
//                   spreadRadius: 2,
//                 )
//               ],
//             ),
//             child: const Icon(
//               Icons.person,
//               size: 40,
//               color: Colors.grey,
//             ),
//           ),
//           const SizedBox(
//             height: 30,
//           ),
//           Text(
//             name != null ? name! : "Mohammad Mustafa",
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const SizedBox(height: 10),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: const [
//               Icon(Icons.location_on),
//               SizedBox(
//                 width: 5,
//               ),
//               Text(
//                 "Birta-4, Birgunj, Nepal",
//                 style: TextStyle(fontSize: 16),
//               ),
//             ],
//           ),
//           const SizedBox(
//             height: 40,
//           ),
//           _buildContainer("Blood group: A+"),
//           _buildContainer("Club Name: ABC"),
//           _buildContainer("Member-type: ")
//         ],
//       ),
//     );
//   }

//   Padding _buildContainer(String title) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 15),
//       child: Container(
//         width: double.infinity,
//         height: 60,
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12),
//           boxShadow: [
//             BoxShadow(
//               offset: const Offset(3, 6),
//               color: Colors.grey.withOpacity(0.5),
//               blurRadius: 12,
//               spreadRadius: 2,
//             )
//           ],
//         ),
//         child: Row(
//           children: [
//             Text(
//               title,
//               style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
