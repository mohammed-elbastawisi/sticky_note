import 'package:flutter/foundation.dart';

class DefaultNoteDetails with ChangeNotifier {
  String id;
  String content;
  String title;
  DateTime dateTime;

  DefaultNoteDetails({
    this.id,
    this.content,
    this.title,
    this.dateTime,
  });
}
