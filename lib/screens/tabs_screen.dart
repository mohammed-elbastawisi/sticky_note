import 'package:flutter/material.dart';

import './default_note_screen.dart';
import './priority_note_screen.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: buildAppBar(),
        body: TabBarView(
          children: <Widget>[
            DefaultNoteScreen(),
            PriorityNoteScreen(),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text('NOTES'),
      bottom: TabBar(
        tabs: <Widget>[
          buildTab('Daily note'),
          buildTab('Important note'),
        ],
      ),
    );
  }

  Tab buildTab(title) {
    return Tab(
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          color: Colors.brown.shade100,
        ),
      ),
    );
  }
}
