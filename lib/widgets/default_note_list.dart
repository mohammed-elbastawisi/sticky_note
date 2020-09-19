import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../provider/default_note_controller.dart';
import '../screens/default_note_edit_screen.dart';

class DefaultNoteList extends StatelessWidget {
  String id;
  String title;
  String content;
  DateTime dateTime;

  DefaultNoteList({
    @required this.id,
    @required this.title,
    @required this.content,
    @required this.dateTime,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Icon(Icons.note),
      ),
      title: Text(title),
      subtitle: Text(DateFormat('yyyy-MM-dd hh:mm').format(dateTime)),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(EditNoteScreen.routeName, arguments: id);
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                try {
                  await Provider.of<DefaultNoteController>(context,
                          listen: false)
                      .deleteNoteData(id);
                } catch (_) {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: Text('An error occurred'),
                      content: Text('Can not delete this note!'),
                      actions: <Widget>[
                        FlatButton(
                          child: Text('OK'),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    ),
                  );
                }
//
              },
            ),
          ],
        ),
      ),
    );
  }
}
