import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './priority_note_edit_screen.dart';
import '../provider/priotity_note_controller.dart';
import '../widgets/custom_components/loading_component.dart';
import '../widgets/priority_note_list.dart';

class PriorityNoteScreen extends StatefulWidget {
  static const routeName = '/priority-note';

  @override
  _PriorityNoteScreenState createState() => _PriorityNoteScreenState();
}

class _PriorityNoteScreenState extends State<PriorityNoteScreen> {
  var _pageLoading = false;
  PriorityNoteController importantNote;
  @override
  void initState() {
    setState(() {
      _pageLoading = true;
    });
    importantNote = Provider.of<PriorityNoteController>(context, listen: false);
    importantNote.fetchNoteData().then((ctx) => setState(() {
          _pageLoading = false;
        }));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final importantNote = Provider.of<PriorityNoteController>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
//      appBar: AppBar(
//        title: Text('Priority Notes'),
//
      body: RefreshIndicator(
        onRefresh: () async {
          await Provider.of<PriorityNoteController>(context, listen: false)
              .fetchNoteData();
        },
        child: _pageLoading
            ? LoadingComponent(
                color: Theme.of(context).primaryColor,
              )
            : ListView.builder(
                itemCount: importantNote.priorityList.length,
                itemBuilder: (ctx, index) => Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  elevation: 5,
                  color: Colors.brown.shade100,
                  child: Dismissible(
                      key: ValueKey(importantNote.priorityList[index].id),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        color: Theme.of(context).errorColor,
                        child: Icon(
                          Icons.delete,
                          size: 40,
                        ),
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(right: 10),
                      ),
                      onDismissed: (_) async {
                        await importantNote.deleteNoteData(
                            importantNote.priorityList[index].id);
                      },
                      confirmDismiss: (_) {
                        return showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  title: Text('Delete this note !'),
                                  content: Text('Do you want to delete this ?'),
                                  elevation: 5,
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text("YES"),
                                      onPressed: () {
                                        importantNote.deleteNoteData(
                                            importantNote
                                                .priorityList[index].id);
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    FlatButton(
                                      child: Text("NO"),
                                      onPressed: () {
//                      note.deletePriorityNote(note.priorityList[index].id);
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                ));
                      },
                      child: PriorityNoteList(
                        id: importantNote.priorityList[index].id,
                        title: importantNote.priorityList[index].title,
                        priority: importantNote.priorityList[index].priority,
                        dateTime: importantNote.priorityList[index].dateTime,
                      )),
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.of(context).pushNamed(EditPriorityNoteScreen.routeName);
        },
      ),
    );
  }
}
