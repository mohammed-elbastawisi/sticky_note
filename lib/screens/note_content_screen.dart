import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/default_note_controller.dart';
import '../widgets/default_note_content_widget.dart';

class NoteContentScreen extends StatelessWidget {
  static const routeName = '/note-content';

  @override
  Widget build(BuildContext context) {
    final chosenId = ModalRoute.of(context).settings.arguments as String;
//    final note = Provider.of<DefaultNoteController>(context);
    final chosenNote =
        Provider.of<DefaultNoteController>(context, listen: false)
            .findNoteById(chosenId);
    return Scaffold(
      appBar: AppBar(
        title: Text('Note Content'),
      ),
      body: DefaultNoteContentWidget(
        chosenNote.title,
        chosenNote.content,
      ),
    );
  }
}
