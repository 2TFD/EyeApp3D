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
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.camera_alt), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.photo_library_outlined), label: ''),
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
