import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:stickynote/model/default_note.dart';
import 'package:stickynote/provider/controller.dart';

import '../model/periority_note.dart';

class PriorityNoteController extends Controller<PriorityNoteDetails>
    with ChangeNotifier {
  List<PriorityNoteDetails> _priorityList = [];

  List<PriorityNoteDetails> get priorityList {
    return [..._priorityList];
  }

  PriorityNoteDetails findNoteById(String id) {
    return _priorityList.firstWhere((note) => note.id == id);
  }

  Future<void> fetchNoteData() async {
    const url = 'https://note-database-affbe.firebaseio.com/PriorityNotes.json';
    try {
      final response = await http.get(url);
      final _extractedData = json.decode(response.body) as Map<String, dynamic>;
      List<PriorityNoteDetails> _loadedNote = [];
      if (_extractedData == null) {
        return;
      }
      _extractedData.forEach(
        (noteId, note) {
          _loadedNote.add(
            PriorityNoteDetails(
              id: noteId,
              title: note['title'],
              content: note['content'],
              priority: note['priority'],
              dateTime: DateTime.parse(note['dateTime']),
            ),
          );
          _priorityList = _loadedNote;
          notifyListeners();
        },
      );
    } catch (error) {
      print(error);
    }
  }

  Future<void> updateNoteData(
      String id, DefaultNoteDetails newUpdatedNote) async {
    PriorityNoteDetails priorityNoteDetails = newUpdatedNote;
    final url =
        'https://note-database-affbe.firebaseio.com/PriorityNotes/$id.json';
    final noteIndex = _priorityList.indexWhere((note) => note.id == id);
    if (noteIndex >= 0) {
      final response = await http.patch(
        url,
        body: json.encode(
          {
            'id': priorityNoteDetails.id,
            'title': priorityNoteDetails.title,
            'content': priorityNoteDetails.content,
            'priority': priorityNoteDetails.priority,
            'dateTime': priorityNoteDetails.dateTime.toIso8601String(),
          },
        ),
      );
      _priorityList[noteIndex] = priorityNoteDetails;
      notifyListeners();
    }
  }

  Future<void> deleteNoteData(String id) async {
    final url =
        'https://note-database-affbe.firebaseio.com/PriorityNotes/$id.json';

    final _deletedId = _priorityList.indexWhere((item) => item.id == id);
    var _deletedNote = _priorityList[_deletedId];
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _priorityList.insert(_deletedId, _deletedNote);
      notifyListeners();
    } else {
      _deletedNote = null;
    }
    _priorityList.removeAt(_deletedId);
    notifyListeners();
  }

  Future<void> addNewNote(DefaultNoteDetails newNote) async {
    PriorityNoteDetails priorityNoteDetails = newNote;
    const url = 'https://note-database-affbe.firebaseio.com/PriorityNotes.json';
    final response = await http.post(
      url,
      body: json.encode(
        {
          'id': priorityNoteDetails.id,
          'title': priorityNoteDetails.title,
          'content': priorityNoteDetails.content,
          'priority': priorityNoteDetails.priority,
          'dateTime': priorityNoteDetails.dateTime.toIso8601String(),
        },
      ),
    );
    newNote.id = json.decode(response.body)['name'];
    _priorityList.add(newNote);
    notifyListeners();
  }
}
