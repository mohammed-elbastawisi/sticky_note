import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PriorityContentWidget extends StatelessWidget {
  String title;
  String content;
  DateTime dateTime;

  PriorityContentWidget(this.title, this.content, this.dateTime);
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                top: 15,
                bottom: 5,
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
                top: 15,
                bottom: 5,
              ),
              child: Text(
                content,
                style: TextStyle(
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 15,
                bottom: 5,
              ),
              child: Text(
                'Note Date : ' +
                    DateFormat('dd / MM / yyyy     hh:mm').format(dateTime),
                style: TextStyle(
                  fontSize: 12,
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
