import 'package:flutter/material.dart';
import 'mainFetchData.dart';

class SideList extends StatelessWidget {
  SideList({@required this.list});

  final List<Note> list;
  GlobalKey<_MainFetchDataState> _mainFetchData = GlobalKey();

  String _trimStory(String story) {

    if (story.length > 5) {
      return story.substring(0,4).trim();
    } else {
      return story; 
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.0,
      child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              contentPadding:
                  EdgeInsets.only(top: 5.0, right: 10.0, left: 10.0),
              title: Text(list[index].headline),
              subtitle: Text( '${_trimStory(list[index].story)}...'),
              onTap: () => {
                _mainFetchData.currentState.updateView(list[index]),
                print("Did tap note with headline ${list[index].headline} ."),
              },
            );
          }),
    );
  }
}
