import 'package:chat/statcs.dart/staticRouter.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Container(
          height: 400,
          child: Center(
            child: Column(
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.popAndPushNamed(context, 'login');
                    },
                    child: const Text('Login'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
