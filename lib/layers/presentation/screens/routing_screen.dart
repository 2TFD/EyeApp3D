import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RoutingScreen extends StatelessWidget {
  RoutingScreen({super.key, required this.statefulNavigationShell});

  final StatefulNavigationShell statefulNavigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: statefulNavigationShell,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home, color: Colors.white,), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.camera_alt, color: Colors.white,), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.photo_library_outlined, color: Colors.white,), label: ''),
        ],
        currentIndex: statefulNavigationShell.currentIndex,
        onTap: (index)=>statefulNavigationShell.goBranch(
          index,
          initialLocation: index == statefulNavigationShell.currentIndex
        )
      ),
    );
  }
}
