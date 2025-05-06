import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Привет!',
              style: Theme.of(context).textTheme.bodyLarge
            ),
            Text('следуй за инструкциями'),
            SizedBox(height: 60),
            IconButton(
              onPressed: () {
                print('qwe');
                context.go('/reg/howto');
              },
              icon: Icon(Icons.arrow_forward_ios, size: 34),
            ),
          ],
        ),
      ),
    );
  }
}
