import 'package:eyeapp3d/layers/domain/provider/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});


  @override
  Widget build(BuildContext context) {

  String token = 'token';

  // String? text;
    // final cubit = TestCubit();
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(title: Text('settings')),
        body: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            children: [
              Center(
                child: Text(
                  'change token',
                  style: Theme.of(context).textTheme.bodyLarge,
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
                  // Storage().setToken(token);
                  // cubit.setToken(token);
                  UserProvider().setToken(token);
                  context.go('/');
                },
                child: Text('Save', style: TextStyle(color: Colors.black)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
