import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './provider/default_note_controller.dart';
import './provider/priotity_note_controller.dart';
import './screens/default_note_edit_screen.dart';
import './screens/default_note_screen.dart';
import './screens/note_content_screen.dart';
import './screens/priority_note_content_screen.dart';
import './screens/priority_note_edit_screen.dart';
import './screens/priority_note_screen.dart';
import './screens/tabs_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: DefaultNoteController(),
        ),
        ChangeNotifierProvider.value(
          value: PriorityNoteController(),
        ),
      ],
      child: MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.brown,
            accentColor: Colors.brown.shade200,
          ),
          debugShowCheckedModeBanner: false,
          title: 'Sticky Note',
          home: TabsScreen(),
          routes: {
            DefaultNoteScreen.routeName: (ctx) => DefaultNoteScreen(),
            NoteContentScreen.routeName: (ctx) => NoteContentScreen(),
            EditNoteScreen.routeName: (ctx) => EditNoteScreen(),
            PriorityNoteScreen.routeName: (ctx) => PriorityNoteScreen(),
            EditPriorityNoteScreen.routeName: (ctx) => EditPriorityNoteScreen(),
            PriorityNoteContentScreen.routeName: (ctx) =>
                PriorityNoteContentScreen(),
          }),
    );
  }
}
