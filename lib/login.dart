import 'package:fetch_json/loginCard.dart';
import 'package:flutter/material.dart';
import 'Token.dart';

Token token; 

class Login extends StatefulWidget {
  @override
  _MainLogin createState() => _MainLogin();
}

class _MainLogin extends State<Login> {

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
            child: LoginCard(),
      ),  
    );
  }
}