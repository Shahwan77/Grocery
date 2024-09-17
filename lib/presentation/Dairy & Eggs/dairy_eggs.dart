import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DairyEggs extends StatelessWidget {
  const DairyEggs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.green.shade800,
        title: Text('DAIRY & EGGS',style: TextStyle(color: Colors.white),),
      ),
    );
  }
}
