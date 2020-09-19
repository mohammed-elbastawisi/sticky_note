import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/priotity_note_controller.dart';
import '../widgets/priority_note_content_widget.dart';

class PriorityNoteContentScreen extends StatelessWidget {
  static const routeName = '/priority-content-screen';
  @override
  Widget build(BuildContext context) {
    final noteId = ModalRoute.of(context).settings.arguments as String;
    final note =
        Provider.of<PriorityNoteController>(context).findNoteById(noteId);
    return Scaffold(
      appBar: AppBar(
        title: Text('Important Note Content'),
      ),
      backgroundColor: Theme.of(context).accentColor,
      body: PriorityContentWidget(
        note.title,
        note.content,
        note.dateTime,
      ),
    );
  }
}
