import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GetPromtScreen extends StatelessWidget {
  GetPromtScreen({super.key});

  String promt = 'cat';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          TextField(
            maxLines: 2,
            onChanged: (value) => promt = value,
          ),
          CupertinoButton(
            child: Text('generaite!'),
            onPressed: () {
              context.go('/gen/getpromt/viewimage', extra: promt);
            },
          ),
        ],
      ),
    );
  }
}
