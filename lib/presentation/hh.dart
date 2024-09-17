import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  BottomNavBar({required this.selectedIndex, required this.onItemTapped});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 10.0), // Adjust padding as needed
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNavItem(Icons.home_outlined, 0),
              _buildNavItem(Icons.settings_outlined, 1),
              _buildNavItem(Icons.person_outline_sharp, 2),
              _buildNavItem(Icons.logout, 3),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNavItem(IconData icon, int index) {
    return GestureDetector(
      onTap: () => onItemTapped(index),
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: selectedIndex == index ? Colors.white : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 30,
          color: selectedIndex == index ? Color(0xFF800000) : Colors.white,
        ),
      ),
    );
  }
}
