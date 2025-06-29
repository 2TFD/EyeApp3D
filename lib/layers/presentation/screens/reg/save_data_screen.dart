import 'package:eyeapp3d/layers/domain/entity/user.dart';
import 'package:eyeapp3d/layers/domain/provider/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SaveDataScreen extends StatelessWidget {
 const  SaveDataScreen({super.key});

  

  @override
  Widget build(BuildContext context) {
    String token = 'token';
    String name = 'name';
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
                  hintText: 'name',
                  hintStyle: TextStyle(fontSize: 20, color: Colors.grey),
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
                  hintText: 'hf_token',
                  hintStyle: TextStyle(fontSize: 20, color: Colors.grey),
                ),
              ),
              SizedBox(height: 100),

              CupertinoButton(
                color: Colors.white,
                onPressed: () async {
                  // Storage().setAll(name, token);
                  UserProvider().updateUser(
                    User(token: token, tokens: 1000, name: name, isInit: true
                    ),
                  );
                  context.go('/');
                },
                child: Text('complete', style: TextStyle(color: Colors.black)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
