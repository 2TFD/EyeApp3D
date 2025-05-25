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
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(
              children: [
                Center(
                  child: Text(
                    'fill in the fields below',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                SizedBox(height: 60),
                TextField(
                  onChanged: (value) {
                    name = value;
                  },
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    hintText:
                      'name',
                    hintStyle: TextStyle(fontSize: 20, color: Colors.grey)
                  ),
                ),
                SizedBox(height: 60),
                TextField(
                  onChanged: (value) {
                    token = value;
                  },
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    hintText:
                      'hf_token',
                    hintStyle: TextStyle(fontSize: 20, color: Colors.grey)
                  ),
                ),
                SizedBox(height: 100),
                
                CupertinoButton(
                  color: Colors.white,
                  onPressed: () async {
                    Storage().setAll(name, token);
                    context.go('/');
                  },
                  child: Text(
                    'complete',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                
              ],
            ),
        ),
        ),
    );
  }
}
