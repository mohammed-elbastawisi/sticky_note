import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/default_note.dart';
import '../provider/default_note_controller.dart';

class EditNoteScreen extends StatefulWidget {
  static const routeName = '/edit-note';

  @override
  _EditNoteScreenState createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  final _form = GlobalKey<FormState>();
  var _isLoading = false;
  var _editedNote = DefaultNoteDetails(
    id: null,
    dateTime: DateTime.now(),
    content: '',
    title: '',
  );

  @override
  Widget build(BuildContext context) {
    final mediaQuerySize = MediaQuery.of(context).size;

    final noteId = ModalRoute.of(context).settings.arguments as String;

    if (noteId != null) {
      _editedNote =
          Provider.of<DefaultNoteController>(context).findNoteById(noteId);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Note'),
      ),
      body: Container(
        color: Theme.of(context).accentColor,
        height: mediaQuerySize.height,
        width: mediaQuerySize.width,
        child: buildForm(context, mediaQuerySize),
      ),
    );
  }

  Form buildForm(BuildContext context, Size mediaQuerySize) {
    Future<void> _saveForm() async {
      final isValid = _form.currentState.validate();
      if (!isValid) {
        return;
      }
      _form.currentState.save();
      setState(() {
        _isLoading = true;
      });
      if (_editedNote.id != null) {
        await Provider.of<DefaultNoteController>(context, listen: false)
            .updateNoteData(_editedNote.id, _editedNote);
      } else {
        await Provider.of<DefaultNoteController>(context, listen: false)
            .addNewNote(_editedNote);
      }
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pop();
    }

    return Form(
      key: _form,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 15,
              ),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Theme.of(context).errorColor),
                  ),
                ),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'You must enter title';
                  }
                  return null;
                },
                initialValue: _editedNote.title,
                onSaved: (value) {
                  _editedNote = DefaultNoteDetails(
                    title: value,
                    dateTime: _editedNote.dateTime,
                    content: _editedNote.content,
                    id: _editedNote.id,
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 15,
              ),
              child: TextFormField(
                initialValue: _editedNote.content,
                decoration: InputDecoration(
                  labelText: 'Content',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Theme.of(context).errorColor),
                  ),
                ),
                maxLines: 2,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'You must add note content';
                  }
                  return null;
                },
                onSaved: (value) {
                  _editedNote = DefaultNoteDetails(
                    title: _editedNote.title,
                    dateTime: _editedNote.dateTime,
                    content: value,
                    id: _editedNote.id,
                  );
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: mediaQuerySize.height * .02),
              child: RaisedButton(
                child: _isLoading
                    ? CircularProgressIndicator(
                        backgroundColor: Theme.of(context).primaryColor,
                      )
                    : Text(
                        'Save',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                elevation: 10,
                splashColor: Theme.of(context).accentColor,
                padding: EdgeInsets.all(mediaQuerySize.height * .02),
                onPressed: () {
                  _saveForm();
                },
                color: Theme.of(context).primaryColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
