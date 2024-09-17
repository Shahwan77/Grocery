import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TeaCoffee extends StatelessWidget {
  const TeaCoffee({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.green.shade800,
        title: Text('TEA & COFFEE',style: TextStyle(color: Colors.white),),
      ),
    );
  }
}
