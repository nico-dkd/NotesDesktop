import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginCard extends StatefulWidget {
  @override
  _LoginCard createState() => _LoginCard();
}

class _LoginCard extends State<LoginCard> {
  String name = "";
  String password = "";

  bool isVisable = false;

  _login(String name, String password) async {
    String basicHeader = "Basic "+ base64Encode(utf8.encode('$name:$password'));

    final response =
        await http.post('http://localhost:8080/api/users/login', headers: {
      'Content-Type': 'application/json',
      'Authorization': basicHeader
    });
    if (response.statusCode == 200) {
      setState(() {
        isVisable = true;
      });
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                child: Center(
                  child: Column(
                    children: <Widget>[
                      TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter email',
                        ),
                        onChanged: (String value) {
                          this.name = value;
                        },
                      ),
                      Visibility(
                        child: Text("Hat geklappt! 🤓"),
                        maintainSize: false,
                        maintainAnimation: true,
                        maintainState: true,
                        visible: isVisable,
                      ),
                    ],
                  ),
                ),
                margin: EdgeInsets.only(
                    top: 20.0, left: 20.0, right: 20.0, bottom: 5.0),
              ),
            ),
            Expanded(
              child: Container(
                child: Center(
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter password',
                    ),
                    onChanged: (String value) {
                      this.password = value;
                    },
                  ),
                ),
                margin: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
              ),
            ),
            GestureDetector(
              onTap: () => {
                print('didTap'),
                _login(this.name, this.password),
              },
              child: Container(
                child: Center(
                  child: Text(
                    'text Text text',
                    textAlign: TextAlign.center,
                  ),
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Color(0xFF00FFD8)),
                height: 50.0,
                margin: EdgeInsets.all(20.0),
              ),
            )
          ],
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Color(0xFF343643),
        ),
        width: 350.0,
        height: 305.0,
      ),
    );
  }
}
