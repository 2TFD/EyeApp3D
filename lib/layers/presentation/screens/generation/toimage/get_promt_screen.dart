import 'package:eyeapp3d/core/brand/price_list.dart';
import 'package:eyeapp3d/layers/domain/provider/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GetPromtScreen extends StatelessWidget {
  GetPromtScreen({super.key});

  String promt = 'null';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                minLines: null,
                maxLines: null,
                onChanged: (value) => promt = value,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              SizedBox(height: 20),
              CupertinoButton(
                color: Colors.white,
                child: Text(
                  'generaite!',
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () async {
                  // int tokens = await Storage().getTokens();
                  int tokens = await UserProvider().getTokens();
                  if (tokens >= PriceList().image_gen) {
                    // Storage().buyForTokens(PriceList().image_gen);
                    UserProvider().buyTokens(PriceList().image_gen);
                    context.go('/gen/getpromt/viewimage', extra: promt);
                  } else {
                    showDialog(
                      context: context,
                      builder:
                          (context) => SimpleDialog(
                            backgroundColor: Colors.transparent,
                            title: Center(child: Text('no tokes(')),
                          ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
