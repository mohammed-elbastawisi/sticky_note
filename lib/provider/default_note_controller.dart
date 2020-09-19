import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import './controller.dart';
import '../model/default_note.dart';

class DefaultNoteController extends Controller<DefaultNoteDetails>
    with ChangeNotifier {
  List<DefaultNoteDetails> _items = [];

  List<DefaultNoteDetails> get item {
    return [..._items];
  }

  @override
  DefaultNoteDetails findNoteById(String id) {
    return _items.firstWhere((note) => note.id == id);
  }

  @override
  Future<void> fetchNoteData() async {
    const url = 'https://note-database-affbe.firebaseio.com/notes.json';
    try {
      final response = await http.get(url);
      final extractedDate = json.decode(response.body) as Map<String, dynamic>;
      List<DefaultNoteDetails> loadedDate = [];
      if (extractedDate == null) {
        return;
      }
      extractedDate.forEach(
        (noteId, noteData) {
          loadedDate.add(
            DefaultNoteDetails(
              id: noteId,
              title: noteData['title'],
              content: noteData['content'],
              dateTime: DateTime.parse(noteData['dateTime']),
            ),
          );
        },
      );
      _items = loadedDate;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  @override
  Future<void> addNewNote(DefaultNoteDetails newNote) async {
    const url = 'https://note-database-affbe.firebaseio.com/notes.json';
    final response = await http.post(
      url,
      body: json.encode(
        {
          'title': newNote.title,
          'id': newNote.id,
          'content': newNote.content,
          'dateTime': newNote.dateTime.toIso8601String(),
        },
      ),
    );
    newNote = DefaultNoteDetails(
      id: json.decode(response.body)['name'],
      dateTime: newNote.dateTime,
      title: newNote.title,
      content: newNote.content,
    );
    _items.add(newNote);
    notifyListeners();
  }

  @override
  Future<void> updateNoteData(String id, DefaultNoteDetails newNote) async {
    final url = 'https://note-database-affbe.firebaseio.com/notes/$id.json';
    final noteIndex = _items.indexWhere((note) => note.id == id);
    if (noteIndex >= 0) {
      newNote = DefaultNoteDetails(
        id: newNote.id,
        content: newNote.content,
        title: newNote.title,
        dateTime: newNote.dateTime,
      );
    }
    _items[noteIndex] = newNote;
    notifyListeners();
    await http.patch(
      url,
      body: json.encode({
        'title': newNote.title,
        'id': newNote.id,
        'content': newNote.content,
        'dateTime': newNote.dateTime.toIso8601String(),
      }),
    );
  }

  @override
  Future<void> deleteNoteData(String id) async {
    final url = 'https://note-database-affbe.firebaseio.com/notes/$id.json';
    final _deletedItemIndex = _items.indexWhere((note) => note.id == id);
    var _existingNote = _items[_deletedItemIndex];
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(_deletedItemIndex, _existingNote);
      notifyListeners();
    } else {
      _existingNote = null;
    }
    _items.removeAt(_deletedItemIndex);
    notifyListeners();
  }

//  DefaultNoteDetails findId(String id) {
//    return _items.firstWhere((note) => note.id == id);
//  }
//
//  Future<void> deleteNote(String id) async {
//    final url = 'https://note-database-affbe.firebaseio.com/notes/$id.json';
//    final _deletedItemIndex = _items.indexWhere((note) => note.id == id);
//    var _existingNote = _items[_deletedItemIndex];
//    final response = await http.delete(url);
//    if (response.statusCode >= 400) {
//      _items.insert(_deletedItemIndex, _existingNote);
//      notifyListeners();
//    } else {
//      _existingNote = null;
//    }
//    _items.removeAt(_deletedItemIndex);
//    notifyListeners();
//  }
//
//  Future<void> addNewNote(DefaultNoteDetails newNote) async {
//    const url = 'https://note-database-affbe.firebaseio.com/notes.json';
//    final response = await http.post(
//      url,
//      body: json.encode(
//        {
//          'title': newNote.title,
//          'id': newNote.id,
//          'content': newNote.content,
//          'dateTime': newNote.dateTime.toIso8601String(),
//        },
//      ),
//    );
//    newNote = DefaultNoteDetails(
//      id: json.decode(response.body)['name'],
//      dateTime: newNote.dateTime,
//      title: newNote.title,
//      content: newNote.content,
//    );
//    _items.add(newNote);
//    notifyListeners();
//  }
//
//  Future<void> fetchNoteData() async {
//    const url = 'https://note-database-affbe.firebaseio.com/notes.json';
//    try {
//      final response = await http.get(url);
//      final extractedDate = json.decode(response.body) as Map<String, dynamic>;
//      List<DefaultNoteDetails> loadedDate = [];
//      if (extractedDate == null) {
//        return;
//      }
//      extractedDate.forEach(
//        (noteId, noteData) {
//          loadedDate.add(
//            DefaultNoteDetails(
//              id: noteId,
//              title: noteData['title'],
//              content: noteData['content'],
//              dateTime: DateTime.parse(noteData['dateTime']),
//            ),
//          );
//        },
//      );
//      _items = loadedDate;
//      notifyListeners();
//    } catch (error) {
//      throw (error);
//    }
//  }
//
//  Future<void> updateNote(String id, DefaultNoteDetails newNote) async {
//    final url = 'https://note-database-affbe.firebaseio.com/notes/$id.json';
//    final noteIndex = _items.indexWhere((note) => note.id == id);
//    if (noteIndex >= 0) {
//      newNote = DefaultNoteDetails(
//        id: newNote.id,
//        content: newNote.content,
//        title: newNote.title,
//        dateTime: newNote.dateTime,
//      );
//    }
//    _items[noteIndex] = newNote;
//    notifyListeners();
//    await http.patch(
//      url,
//      body: json.encode({
//        'title': newNote.title,
//        'id': newNote.id,
//        'content': newNote.content,
//        'dateTime': newNote.dateTime.toIso8601String(),
//      }),
//    );
//  }
}
