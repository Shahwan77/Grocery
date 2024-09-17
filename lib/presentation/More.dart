import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class CustTextField extends StatelessWidget {
  final String? labelText;
  final TextEditingController? controller;
  final double? borderRadius;
  final Color? fillColor;
  final bool? obscureText;
  final Widget? suffix;
  final String? hint;
  final Color? boxColor;
  final TextStyle? labelStyle;
  final double? height;
  final double? width;
  final int? minLines;
  final int? maxLines;

  const CustTextField({
    Key? key,
    this.labelText,
    this.controller,
    this.borderRadius = 14.0,
    this.fillColor = Colors.white,
    this.obscureText = false,
    this.suffix,
    this.hint,
    this.boxColor,
    this.labelStyle,
    this.height,
    this.width,
    this.minLines = 1,
    this.maxLines = null,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius!),
            boxShadow: [
              BoxShadow(
                color: boxColor ?? Colors.indigo.shade200,
                offset: Offset(0, 2),
                blurRadius: 2.0,
                spreadRadius: 1.0,
              ),
            ],
          ),
          child: TextFormField(
            controller: controller,
            obscureText: obscureText!,
            minLines: minLines,
            maxLines: maxLines,
            decoration: InputDecoration(
              labelStyle: labelStyle,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.indigo.shade100),
                borderRadius: BorderRadius.circular(borderRadius!),
              ),
              filled: true,
              fillColor: fillColor,
              suffixIcon: suffix,
              hintText: hint,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(borderRadius!),
              ),
              contentPadding: EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: 16.0,
              ),
            ),
          ),
        ),
        Positioned(
          top: -12, // Adjust the top position for the label
          left: 16, // Adjust the left position as needed
          child: Text(
            labelText ?? '',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}





class SignUpController extends GetxController {
  // Text Controllers
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  RxBool isChecked = false.obs;

  // Observable for password visibility
  var obsecure = true.obs;

  // Category and Type selections
  var selectedCategory = 'Select Category'.obs;
  var selectedType = 'Select Type'.obs;

  // Example category and type lists
  List<String> categories = ['Category 1', 'Category 2', 'Category 3'];
  List<String> types = ['Type 1', 'Type 2', 'Type 3'];

  // Toggles password visibility
  void togglePasswordVisibility() {
    obsecure.value = !obsecure.value;
  }
  void toggleCheckbox(bool? value) {
    isChecked.value = value ?? false;
  }
  // Set selected category
  void setSelectedCategory(String value) {
    selectedCategory.value = value;
  }

  // Set selected type
  void setSelectedType(String value) {
    selectedType.value = value;
  }

  @override
  void onClose() {
    // Dispose controllers when done
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}


// class BottomNavBar extends StatelessWidget {
//   final BottomNavController _controller = Get.put(BottomNavController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       return Container(
//         width: double.infinity, // Adjust to match your layout
//         height: 80.0,
//         decoration: BoxDecoration(
//           color: Color(0xFF005B82), // Set the background color of the Container
//           borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)), // Optional: for rounded corners
//         ),
//         child: BottomNavigationBar(
//           currentIndex: _controller.selectedIndex.value,
//           onTap: (index) => _controller.onItemTapped(index),
//           items: [
//             BottomNavigationBarItem(
//               icon: _buildIcon(0, Icons.home, 'Home'),
//               label: '',
//             ),
//             BottomNavigationBarItem(
//               icon: _buildIcon(1, Icons.search, 'Search'),
//               label: '',
//             ),
//             BottomNavigationBarItem(
//               icon: _buildIcon(2, Icons.notifications, 'Notifications'),
//               label: '',
//             ),
//             BottomNavigationBarItem(
//               icon: _buildIcon(3, Icons.person, 'Profile'),
//               label: '',
//             ),
//           ],
//           selectedItemColor: Colors.blue,
//           unselectedItemColor: Colors.white,
//           elevation: 0.0, // Adjust elevation as needed
//         ),
//       );
//     });
//   }
//
//   Widget _buildIcon(int index, IconData icon, String label) {
//     return Container(
//       padding: EdgeInsets.all(8.0),
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         color: _controller.selectedIndex.value == index
//             ? Colors.white
//             : Colors.transparent,
//       ),
//       child: Icon(
//         icon,
//         color: _controller.selectedIndex.value == index
//             ? Colors.red
//             : Colors.white,
//       ),
//     );
//   }
// }
//
//
// class BottomNavController extends GetxController {
//   var selectedIndex = 0.obs;
//
//   void onItemTapped(int index) {
//     selectedIndex.value = index;
//     // Add your navigation logic here, if needed
//   }
// }


