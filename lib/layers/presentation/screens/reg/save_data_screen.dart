import 'package:eyeapp3d/layers/data/local/storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class SaveDataScreen extends StatelessWidget {
  SaveDataScreen({super.key});

  String token = 'token';
  String name = 'name';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Text(
                'заполните поля ниже',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            SizedBox(height: 60),
            TextField(
              onChanged: (value) {
                name = value;
              },
              decoration: InputDecoration(
                label: Text(
                  'ваше имя',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
            SizedBox(height: 60),
            TextField(
              onChanged: (value) {
                token = value;
              },
              decoration: InputDecoration(
                label: Text(
                  'ваш токен',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
            SizedBox(height: 100),

            CupertinoButton(
              color: Colors.grey,
              onPressed: () async {
                // сохранение данных
                Storage().setAll(name, token);
                context.go('/');
              },
              child: Text(
                'завершить регистрацию',
                style: TextStyle(color: Colors.white),
              ),
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
