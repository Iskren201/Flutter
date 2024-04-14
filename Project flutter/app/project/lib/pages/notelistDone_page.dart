import 'package:flutter/material.dart';

class DoneNoteList extends StatelessWidget {
  const DoneNoteList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Done Notes'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: CircleAvatar(child: Text('D')),
            title: Text('Done Note 1'),
            subtitle: Text('This note is marked as done.'),
            trailing: IconButton(
              icon: Icon(Icons.undo),
              onPressed: () {
                // Implement undo action
              },
            ),
          ),
          Divider(height: 0),
          ListTile(
            leading: CircleAvatar(child: Text('E')),
            title: Text('Done Note 2'),
            subtitle: Text('Another note marked as done.'),
            trailing: IconButton(
              icon: Icon(Icons.undo),
              onPressed: () {
                // Implement undo action
              },
            ),
          ),
          Divider(height: 0),
          ListTile(
            leading: CircleAvatar(child: Text('F')),
            title: Text('Done Note 3'),
            subtitle: Text('Yet another note marked as done.'),
            trailing: IconButton(
              icon: Icon(Icons.undo),
              onPressed: () {
                // Implement undo action
              },
            ),
          ),
          Divider(height: 0),
        ],
      ),
    );
  }
}
