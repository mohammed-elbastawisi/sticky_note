import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/periority_note.dart';
import '../provider/priotity_note_controller.dart';

class EditPriorityNoteScreen extends StatefulWidget {
  static const routeName = '/edit-priority-note';

  @override
  _EditPriorityNoteScreenState createState() => _EditPriorityNoteScreenState();
}

class _EditPriorityNoteScreenState extends State<EditPriorityNoteScreen> {
  final _formKey = GlobalKey<FormState>();
  var _isSaving = false;
  bool _importance = false;
  var _addedNot = PriorityNoteDetails(
    id: null,
    dateTime: DateTime.now(),
    title: '',
    content: '',
    priority: false,
  );

  @override
  Widget build(BuildContext context) {
    final noteId = ModalRoute.of(context).settings.arguments as String;

    if (noteId != null) {
      _addedNot =
          Provider.of<PriorityNoteController>(context).findNoteById(noteId);
    }
    Future<void> _saveForm() async {
      if (_importance) {
        _addedNot.priority = true;
      }
      final validate = _formKey.currentState.validate();
      if (!validate) {
        return;
      }
      setState(() {
        _isSaving = true;
      });
      _formKey.currentState.save();
      if (_addedNot.id != null) {
        await Provider.of<PriorityNoteController>(context, listen: false)
            .updateNoteData(_addedNot.id, _addedNot);
      } else {
        await Provider.of<PriorityNoteController>(context, listen: false)
            .addNewNote(_addedNot);
      }
      setState(() {
        _isSaving = false;
      });
      Navigator.of(context).pop();
    }

    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      appBar: AppBar(
        title: Text('Add Priority Note'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                child: TextFormField(
                  initialValue: _addedNot.title,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'you must enter a title';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Title',
//                      labelStyle: TextStyle(fontSize: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: Theme.of(context).errorColor)),
                  ),
                  textInputAction: TextInputAction.next,
                  onSaved: (val) {
                    _addedNot = PriorityNoteDetails(
                      id: _addedNot.id,
                      title: val,
                      content: _addedNot.content,
                      priority: _addedNot.priority,
                      dateTime: _addedNot.dateTime,
                    );
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                child: TextFormField(
                  initialValue: _addedNot.content,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'you must enter a Content';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Content',
//                      labelStyle: TextStyle(fontSize: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: Theme.of(context).errorColor)),
                  ),
                  maxLines: 3,
                  onSaved: (val) {
                    _addedNot = PriorityNoteDetails(
                      id: _addedNot.id,
                      title: _addedNot.title,
                      content: val,
                      priority: _addedNot.priority,
                      dateTime: _addedNot.dateTime,
                    );
                  },
                ),
              ),
              CheckboxListTile(
                title: Text('important Note'),
                subtitle: Text('Click it to mark as important'),
                secondary: Icon(
                  Icons.priority_high,
                  color: Colors.red,
                  size: 40,
                ),
                value: _importance,
                activeColor: Colors.green,
                onChanged: (bool newValue) {
                  setState(() {
                    _importance = newValue;
                  });
                },
              ),
              Container(
                child: RaisedButton(
                  padding: EdgeInsets.all(15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  color: Theme.of(context).primaryColor,
                  elevation: 10,
                  child: _isSaving
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
                  onPressed: () async {
                    await _saveForm();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

//class EditPriorityNoteForm extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return Form();
//  }
//}
