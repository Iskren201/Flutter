import 'package:flutter/material.dart';

class NoteList extends StatefulWidget {
  const NoteList({Key? key}) : super(key: key);

  @override
  State<NoteList> createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Your Note List'),
            SizedBox(height: 20),
            // ElevatedButton(
            //   onPressed: () {
            //     // Navigate back to the home screen
            //     Navigator.popUntil(context, ModalRoute.withName('/home'));
            //   },
            //   child: Text('Go Back to Home'),
            // ),
          ],
        ),
      ),
    );
  }
}
