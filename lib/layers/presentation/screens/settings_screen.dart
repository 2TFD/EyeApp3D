import 'package:eyeapp3d/layers/data/local/storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class SettingsScreen extends StatelessWidget {
   SettingsScreen({super.key});

  String token = 'token';
  String name = 'name';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('settings'),),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Text(
                'измените данные',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            SizedBox(height: 60),
            TextField(
              onChanged: (value) {
                name = value;
              },
              decoration: InputDecoration(label: Text('ваше имя', style: Theme.of(context).textTheme.bodyMedium,)),
            ),
            SizedBox(height: 60),
            TextField(
              onChanged: (value) {
                token = value;
              },
              decoration: InputDecoration(label: Text('ваш токен', style: Theme.of(context).textTheme.bodyMedium,)),
            ),
            SizedBox(height: 100),
            CupertinoButton(
              child: Text(
                'сохранить',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              color: Colors.grey,
              onPressed: () async {
                // сохранение данных
                Storage().setAll(name, token);
                context.go('/');
              },
            ),

            
            CupertinoButton(
              child: Text('прочитать данные'),
              onPressed: () async {
                print(await Storage().getName());
                print(await Storage().getToken());
              },
            ),
          ],
        ),
      ),
    );
  }
}