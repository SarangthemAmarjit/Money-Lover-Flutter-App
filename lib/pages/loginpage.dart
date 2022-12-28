import 'package:flutter/material.dart';
import 'package:moneylover/pages/googlelogin.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          GestureDetector(
            onTap: () async {
              await Google_login().googlesignin(context);
            },
            child: Center(
              child: Align(
                alignment: Alignment.center,
                child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    width: 280,
                    child: Image.asset(
                      'assets/images/google2.png',
                      fit: BoxFit.fill,
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
