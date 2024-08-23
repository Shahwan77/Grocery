
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextfield extends StatelessWidget {
  final String? lbtxt;
  final String? hint;
  final String? pref;
  final Color? fcsclr;
  final Color? fillclr;
  final double bdrds;
  final bool? isValid;
  final Widget? suffix;
  final Widget? preffix;
  final InputBorder? side;
  final AutovalidateMode? valid;
  final ValueChanged<String>? onchange;
  final TextEditingController? controller;
  final bool? obsecuretext;
  final String? Function(String?)? validator;
  final void Function(String?)? on_saveds; // Add this parameter
  final String? Function(String?)? Validators;
  final TextInputType? keytype;

  const CustomTextfield({
    Key? key,
    this.lbtxt,
    this.fcsclr,
    this.fillclr,
    this.side,
    required this.bdrds,
    this.isValid,
    this.obsecuretext,
    this.onchange,
    this.preffix,
    this.suffix, this.valid,
    this.validator,
    this.controller,
    this.on_saveds,
    this.Validators,  this.hint, this.pref, this.keytype,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      validator: validator,
      autovalidateMode: valid,
      obscureText: obsecuretext ?? false,
      keyboardType: keytype,
      controller:controller ,
      onSaved: on_saveds,
      decoration: InputDecoration(contentPadding: EdgeInsets.symmetric(vertical: 15.h,horizontal: 10.w),
        filled: true,
        fillColor: fillclr,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(bdrds),
        ),
        labelText: lbtxt,
        //labelStyle: Labelstyle.Default_txt,
        focusColor: fcsclr,
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey,fontWeight: FontWeight.w400),
        prefix: Text(pref ?? ''),

        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(bdrds),
        ),
        suffixIcon: suffix,
        prefixIcon:preffix
      ),
      // style: Labelstyle.Field_txt.copyWith(fontSize: 14.0),
      onChanged: onchange,
    );
  }
}