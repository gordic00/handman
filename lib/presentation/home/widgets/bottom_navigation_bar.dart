import 'package:flutter/material.dart';
import 'package:handman/core/helper/app_navigator.dart';
import 'package:handman/presentation/home/pages/home.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  const BottomNavigationBarWidget({super.key});

  @override
  State<BottomNavigationBarWidget> createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  int selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
      if (index == 0) {
        AppNavigator.pushReplacement(context, HomePage(search: ''));
      }
      if (index == 1) {
        AppNavigator.pushReplacement(context, HomePage(search: ''));
      }
      if (index == 2) {
        AppNavigator.pushReplacement(context, HomePage(search: ''));
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.black,
      backgroundColor: Colors.blueAccent,
      iconSize: 24.0,
      type: BottomNavigationBarType.fixed,
      onTap: _onItemTapped, // Handle item taps
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: '',
        ),
      ],
    );
  }
}
