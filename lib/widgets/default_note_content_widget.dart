import 'package:flutter/material.dart';

class DefaultNoteContentWidget extends StatelessWidget {
  String title;
  String content;

  DefaultNoteContentWidget(
    this.title,
    this.content,
  );

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Container(
      height: mediaQuery.height,
      width: mediaQuery.width,
      color: Theme.of(context).accentColor,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                top: mediaQuery.height * .02,
                bottom: mediaQuery.height * .02,
              ),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: mediaQuery.height * .02,
                bottom: mediaQuery.height * .02,
              ),
              child: Text(
                content,
                style: TextStyle(
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
