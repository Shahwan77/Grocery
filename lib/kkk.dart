// import 'package:flutter/material.dart';
//
// class CustomBottomNavBarPage extends StatefulWidget {
//   @override
//   _CustomBottomNavBarPageState createState() => _CustomBottomNavBarPageState();
// }
//
// class _CustomBottomNavBarPageState extends State<CustomBottomNavBarPage> {
//   int _selectedIndex = 0;
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.lightBlue[50],
//       appBar: AppBar(
//         title: Text('Custom Bottom Nav Bar'),
//         backgroundColor: Colors.black,
//       ),
//       body: Center(
//         child: Text(
//           'Selected Tab: ${_selectedIndex + 1}',
//           style: TextStyle(fontSize: 24),
//         ),
//       ),
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
//         child: Container(
//           height: 70,
//           decoration: BoxDecoration(
//             color: Colors.black,
//             borderRadius: BorderRadius.circular(35),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black26,
//                 blurRadius: 10,
//                 offset: Offset(0, 5),
//               ),
//             ],
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               _buildNavBarItem(
//                 icon: Icons.home,
//                 index: 0,
//               ),
//               _buildNavBarItem(
//                 icon: Icons.search,
//                 index: 1,
//               ),
//               _buildNavBarItem(
//                 icon: Icons.favorite,
//                 index: 2,
//               ),
//               _buildNavBarItem(
//                 icon: Icons.person,
//                 index: 3,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildNavBarItem({required IconData icon, required int index}) {
//     return GestureDetector(
//       onTap: () => _onItemTapped(index),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             icon,
//             color: _selectedIndex == index ? Colors.red : Colors.white,
//             size: 28,
//           ),
//           if (_selectedIndex == index)
//             Container(
//               margin: EdgeInsets.only(top: 4),
//               width: 8,
//               height: 8,
//               decoration: BoxDecoration(
//                 color: Colors.red,
//                 shape: BoxShape.circle,
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }
