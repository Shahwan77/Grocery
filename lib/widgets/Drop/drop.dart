import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../presentation/sign_up_screen/controller/signup_controller.dart';

class Drop extends StatelessWidget {
  Drop({super.key});
  final DropController signupController = Get.put(DropController());

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Number Dropdown
        Expanded(
          child: Obx(
                () => DropdownButtonFormField<int>(
              value: signupController.selectedNumber.value,
              onChanged: (value) {
                signupController.selectedNumber.value = value;
              },
              items: signupController.numbers.map((number) {
                return DropdownMenuItem<int>(
                  value: number,
                  child: Text(number.toString()),
                );
              }).toList(),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.shade200,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
                hintText: 'Day',hintStyle: TextStyle(
                color: Colors.grey,height: 2
              ),
              ),
            ),
          ),
        ),
        SizedBox(width: 10.w), // Spacing between dropdowns

        // Month Dropdown
        Expanded(
          child: Obx(
                () => DropdownButtonFormField<String>(
              value: signupController.selectedMonth.value,
              onChanged: (value) {
                signupController.selectedMonth.value = value;
              },
              items: signupController.months.map((month) {
                return DropdownMenuItem<String>(
                  value: month,
                  child: Text(month),
                );
              }).toList(),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.shade200,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 3.w),
                hintText: 'Month',hintStyle:TextStyle(
                color: Colors.grey,height: 2
              ),
              ),
            ),
          ),
        ),
        SizedBox(width: 10.w), // Spacing between dropdowns

        // Year Dropdown
        Expanded(
          child: Obx(
                () => DropdownButtonFormField<int>(
              value: signupController.selectedYear.value,
              onChanged: (value) {
                signupController.selectedYear.value = value;
              },
              items: signupController.years.map((year) {
                return DropdownMenuItem<int>(
                  value: year,
                  child: Text(year.toString()),
                );
              }).toList(),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.shade200,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
                hintText: 'Year',hintStyle: TextStyle(
                color: Colors.grey,height: 2
              ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class DropController extends GetxController {
  // Define lists for dropdown values
  final List<int> numbers = List.generate(30, (index) => index + 1);
  final List<String> months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];
  final List<int> years = List.generate(100, (index) => 1924 + index);

  // Define selected values as observables
  var selectedNumber = Rxn<int>();
  var selectedMonth = Rxn<String>();
  var selectedYear = Rxn<int>();
}