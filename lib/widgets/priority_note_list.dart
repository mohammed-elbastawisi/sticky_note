import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../screens/priority_note_content_screen.dart';
import '../screens/priority_note_edit_screen.dart';

class PriorityNoteList extends StatelessWidget {
  String id;
  String title;
  bool priority;
  DateTime dateTime;

  PriorityNoteList({
    @required this.id,
    @required this.title,
    @required this.priority,
    @required this.dateTime,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).pushNamed(
        PriorityNoteContentScreen.routeName,
        arguments: id,
      ),
      splashColor: Theme.of(context).primaryColor,
      child: ListTile(
        leading: priority
            ? Icon(
                Icons.priority_high,
                color: Colors.red,
              )
            : Icon(
                Icons.low_priority,
                color: Colors.green,
              ),
        title: Text(title),
        subtitle: Text(
          DateFormat('dd-MM-yyyy  hh:mm').format(dateTime),
        ),
        trailing: Container(
          width: 100,
          child: Row(
//                  crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    EditPriorityNoteScreen.routeName,
                    arguments: id,
                  );
//                        print('delete edit pressed');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
