import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DatePickerStack extends StatefulWidget {
  final bool isCheckboxChecked; // Add a parameter for checkbox state

  DatePickerStack({required this.isCheckboxChecked}); // Update the constructor

  @override
  _DatePickerStackState createState() => _DatePickerStackState();
}

class _DatePickerStackState extends State<DatePickerStack> {
  DateTime? _startDate;
  DateTime? _endDate;

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    if (!widget.isCheckboxChecked) {
      return;
    }

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != (isStartDate ? _startDate : _endDate)) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () => _selectDate(context, true), // Select start date
              child: Container(
                height: 38.h,
                width: 156.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x803a80a4),
                      offset: Offset(0, 2),
                      blurRadius: 2.0,
                      spreadRadius: 1.0,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: Center(
                  child: Text(
                    _startDate != null
                        ? '${_startDate!.day}/${_startDate!.month}/${_startDate!.year}'
                        : '',
                    style: TextStyle(fontSize: 14.sp, color: Colors.black),
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            GestureDetector(
              onTap: () => _selectDate(context, false), // Select end date
              child: Container(
                height: 38.h,
                width: 156.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x803a80a4),
                      offset: Offset(0, 2),
                      blurRadius: 2.0,
                      spreadRadius: 1.0,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: Center(
                  child: Text(
                    _endDate != null
                        ? '${_endDate!.day}/${_endDate!.month}/${_endDate!.year}'
                        : '',
                    style: TextStyle(fontSize: 14.sp, color: Colors.black),
                  ),
                ),
              ),
            ),
          ],
        ),
        // Positioned Start Date label
        Positioned(
          top: -12,
          left: 16,
          child: Text(
            'Start Date',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        // Positioned End Date label for the second container
        Positioned(
          top: -12,
          left: 200,
          child: Text(
            'End Date',
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
