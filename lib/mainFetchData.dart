import 'dart:convert';
// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MainFetchData extends StatefulWidget {
  @override
  _MainFetchDataState createState() => _MainFetchDataState();
}

class _MainFetchDataState extends State<MainFetchData> {
  
  List<Note> list = List();
  var isLoading = false;

  _fetchData() async {
    setState(() {
      isLoading = true;
    });
    final response =
        await http.get('http://localhost:8080/api/users/notes', headers: {
      'Content-Type': 'application/json',
      'Authorization': "Bearer mFnIA4pn6LRqIFLzC89glQ=="
    });
    if (response.statusCode == 200) {
      list = (json.decode(response.body) as List)
          .map((data) => new Note.fromJson(data))
          .toList();
      setState(() {
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load notes');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Fetch Data JSON"),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: RaisedButton(
            child: new Text("Fetch Data"),
            onPressed: _fetchData,
          ),
        ),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    contentPadding: EdgeInsets.all(10.0),
                    title: new Text(list[index].headline),
                    subtitle: new Text(list[index].story),
                  );
                }));
  }
}

class Note {
  final String headline;
  final String story;
  Note._({this.headline, this.story});
  factory Note.fromJson(Map<String, dynamic> json) {
    return new Note._(
      headline: json['headline'],
      story: json['story'],
    );
  }
}
