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
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey[800],
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.photo_filter_rounded), label: ''),
        ],
        currentIndex: statefulNavigationShell.currentIndex,
        onTap: (index)=>statefulNavigationShell.goBranch(
          index,
          initialLocation: index == statefulNavigationShell.currentIndex
        )
      ),
    );
    // bool first = true;
    // bool second = false;
    // bool therd = false;
    // void onFirst() {
    //   first = true;
    //   second = false;
    //   therd = false;
    //   // setState(() {});
    // }

    // void onsecond() {
    //   first = false;
    //   second = true;
    //   therd = false;
    //   // setState(() {});
    // }

    // void onTherd() {
    //   first = false;
    //   second = false;
    //   therd = true;
    //   // setState(() {});
    // }

    // return Stack(
    //   children: [
    //     GestureDetector(
    //       onTap: () => FocusScope.of(context).unfocus(),
    //       child: SafeArea(child: widget.statefulNavigationShell),
    //     ),
    //     Positioned(
    //       bottom: 0,
    //       left: 0,
    //       right: 0,
    //       child: Container(
    //         color: Colors.transparent,
    //         width: double.infinity,
    //         height: 100,
    //         padding: EdgeInsets.all(15),
    //         child: Center(
    //           child: Container(
    //             decoration: BoxDecoration(
    //               color: Colors.grey[900],
    //               borderRadius: BorderRadius.circular(20),
    //             ),
    //             height: 80,
    //             width: double.infinity,
    //             child: Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceAround,
    //               children: [
    //                 Column(
    //                   mainAxisAlignment: MainAxisAlignment.center,
    //                   children: [
    //                     IconButton(
    //                       onPressed: () {
    //                         widget.statefulNavigationShell.goBranch(0);
    //                         onFirst();
    //                       },
    //                       icon: Icon(Icons.home),
    //                     ),
    //                     Container(
    //                       color: first ? Colors.white : Colors.transparent,
    //                       height: 1,
    //                       width: 10,
    //                     ),
    //                   ],
    //                 ),
    //                 Column(
    //                   mainAxisAlignment: MainAxisAlignment.center,
    //                   children: [
    //                     IconButton(
    //                       onPressed: () {
    //                         widget.statefulNavigationShell.goBranch(1);
    //                         onsecond();
    //                       },
    //                       icon: Icon(Icons.add),
    //                     ),
    //                     Container(
    //                       color: second ? Colors.white : Colors.transparent,
    //                       height: 1,
    //                       width: 10,
    //                     ),
    //                   ],
    //                 ),
    //                 Column(
    //                   mainAxisAlignment: MainAxisAlignment.center,
    //                   children: [
    //                     IconButton(
    //                       onPressed: () {
    //                         widget.statefulNavigationShell.goBranch(2);
    //                         onTherd();
    //                       },
    //                       icon: Icon(Icons.photo_filter_rounded),
    //                     ),
    //                     Container(
    //                       color: therd ? Colors.white : Colors.transparent,
    //                       height: 1,
    //                       width: 10,
    //                     ),
    //                   ],
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ),
    //       ),
    //     ),
    //   ],
    // );
  }
}
