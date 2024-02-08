import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

// ignore: must_be_immutable
class MyBottomNavBar extends StatelessWidget {
  void Function(int)? onTabChange;
  MyBottomNavBar({super.key, required this.onTabChange});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: GNav(
            color: const Color(0xFF272727),
            activeColor: const Color(0xFFFF2D1A),
            tabActiveBorder: Border.all(color: Colors.white),
            tabBackgroundColor: Colors.grey.shade300,
            mainAxisAlignment: MainAxisAlignment.center,
            tabBorderRadius: 16,
            onTabChange: (value) => onTabChange!(value),
            tabs: const [
              GButton(icon: Icons.home, text: 'Shop'),
              GButton(icon: Icons.shopping_bag_rounded, text: 'Cart'),
            ]));
  }
}
