import 'package:stickynote/model/default_note.dart';

class PriorityNoteDetails extends DefaultNoteDetails {
  bool priority;

  PriorityNoteDetails({
    String id,
    String title,
    String content,
    DateTime dateTime,
    this.priority = false,
  }) : super(
          id: id,
          title: title,
          content: content,
          dateTime: dateTime,
        );
}
