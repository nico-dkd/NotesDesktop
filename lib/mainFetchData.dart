import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'login.dart';
import 'sideList.dart';

class MainFetchData extends StatefulWidget {
  
  @override
  _MainFetchDataState createState() => _MainFetchDataState();
}

class _MainFetchDataState extends State<MainFetchData> {
  List<Note> list = List();
  var isLoading = true;
  Note note;
  
  updateView(Note note) {
    setState(() {
      this.note = note;
    });
  }

  _fetchData() async {
    setState(() {
      isLoading = true;
    });
    final response =
        await http.get('http://localhost:8080/api/users/notes', headers: {
      'Content-Type': 'application/json',
      'Authorization': token.bearer,
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
  void initState() {

    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes"),
        leading: Container(),
      ),
      body: Container(
        child: Row(
          children: <Widget>[
            SideList(
              list: list,
            ),
            Expanded(
              child: Container(
                child: Column(children: <Widget>[
                  Text(note.headline),
                  Expanded(child: Text(note.story),),
                ],),
              ),
            ),
          ],
        ),
      ),
    );
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


// Scaffold(
//       appBar: AppBar(
//         title: Text("Notes"),
//         leading: Container(),
//       ),
//       body: Container(
//         child: Row(
//           children: <Widget>[
//             SideList(
//               list: list,
//             ),
//             Expanded(
//               child: Container(
//                 child: isLoading
//                     ? Center(
//                         child: CircularProgressIndicator(),
//                       )
//                     : ListView.builder(
//                         itemCount: list.length,
//                         itemBuilder: (BuildContext context, int index) {
//                           return ListTile(
//                             contentPadding: EdgeInsets.all(10.0),
//                             title: new Text(list[index].headline),
//                             subtitle: new Text(list[index].story),
//                           );
//                         }),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );