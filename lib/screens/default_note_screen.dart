import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './default_note_edit_screen.dart';
import './note_content_screen.dart';
import '../provider/default_note_controller.dart';
import '../widgets/custom_components/loading_component.dart';
import '../widgets/default_note_list.dart';

class DefaultNoteScreen extends StatefulWidget {
  static const routeName = '/main-screen';

//  @override
  _DefaultNoteScreenState createState() => _DefaultNoteScreenState();
}

class _DefaultNoteScreenState extends State<DefaultNoteScreen> {
  var _isDataLoaded = false;
  DefaultNoteController defaultNoteController;

  @override
  void initState() {
    try {
      setState(() {
        _isDataLoaded = true;
      });
      defaultNoteController =
          Provider.of<DefaultNoteController>(context, listen: false);
      defaultNoteController.fetchNoteData().then((_) {
        setState(() {
          _isDataLoaded = false;
        });
      });
    } catch (_) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          elevation: 5,
          title: Text('An error occured'),
          content:
              Text('an error occured please check your internet connection'),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        ),
      );
    }
    super.initState();
  }

////  var _isLoading = false;
//  @override
//  void didChangeDependencies() async {
//    try {
//      if (!_isDataLoaded) {
//        await Provider.of<NoteDataService>(context, listen: false)
//            .fetchNoteData();
//        setState(() {
//          _isDataLoaded = true;
//        });
//      }
//    } catch (_) {
//      showDialog(
//        context: context,
//        builder: (ctx) => AlertDialog(
//          elevation: 5,
//          title: Text('An error occured'),
//          content:
//              Text('an error occured please check your internet connection'),
//          actions: <Widget>[
//            FlatButton(
//              child: Text('OK'),
//              onPressed: () => Navigator.of(context).pop(),
//            )
//          ],
//        ),
//      );
//    }
//
//    super.didChangeDependencies();
//  }

  @override
  Widget build(BuildContext context) {
    final mediaQuerySize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: RefreshIndicator(
        onRefresh: () async {
          await Provider.of<DefaultNoteController>(context, listen: false)
              .fetchNoteData();
        },
        child: _isDataLoaded
            ? LoadingComponent(color: Theme.of(context).primaryColor)
            : buildNodeDataList(
                context,
                mediaQuerySize,
              ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.of(context).pushNamed(EditNoteScreen.routeName);
        },
      ),
    );
  }

  Widget buildNodeDataList(
    BuildContext ctx,
    Size mediaQuery,
  ) {
    return Container(
      height: mediaQuery.height,
      child: ListView.builder(
        itemBuilder: (ctx, i) => Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          elevation: 5,
          color: Colors.brown.shade100,
          child: InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(
                NoteContentScreen.routeName,
                arguments: defaultNoteController.item[i].id,
              );
            },
            child: DefaultNoteList(
              id: defaultNoteController.item[i].id,
              title: defaultNoteController.item[i].title,
              content: defaultNoteController.item[i].content,
              dateTime: defaultNoteController.item[i].dateTime,
            ),
          ),
        ),
        itemCount: defaultNoteController.item.length,
      ),
    );
  }
}
