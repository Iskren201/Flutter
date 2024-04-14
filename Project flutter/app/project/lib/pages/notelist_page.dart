import 'package:flutter/material.dart';
import 'notelistDone_page.dart';

class NoteList extends StatefulWidget {
  const NoteList({Key? key}) : super(key: key);

  @override
  State<NoteList> createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  bool _showDoneNotes = false; // Track whether to show done notes

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
        actions: [
          IconButton(
            icon: Icon(Icons.done_all),
            onPressed: () {
              setState(() {
                _showDoneNotes = !_showDoneNotes; // Toggle the state
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildNoteList(),
          ),
          if (_showDoneNotes) ...[
            Divider(),
            Expanded(
              child: DoneNoteList(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildNoteList() {
    return ListView(
      children: <Widget>[
        ListTile(
          leading: CircleAvatar(child: Text('A')),
          title: Text('Headline'),
          subtitle: Text('Supporting text'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  // Implement edit functionality
                },
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  // Implement delete functionality
                },
              ),
              IconButton(
                icon: Icon(Icons.check_circle),
                onPressed: () {
                  // Implement mark as done functionality
                },
              ),
            ],
          ),
        ),
        Divider(height: 0),
        ListTile(
          leading: CircleAvatar(child: Text('B')),
          title: Text('Headline'),
          subtitle: Text(
            'Longer supporting text to demonstrate how the text wraps and how the leading and trailing widgets are centered vertically with the text.',
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  // Implement edit functionality
                },
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  // Implement delete functionality
                },
              ),
              IconButton(
                icon: Icon(Icons.check_circle),
                onPressed: () {
                  // Implement mark as done functionality
                },
              ),
            ],
          ),
        ),
        Divider(height: 0),
        ListTile(
          leading: CircleAvatar(child: Text('C')),
          title: Text('Headline'),
          subtitle: Text(
            "Longer supporting text to demonstrate how the text wraps and how setting 'ListTile.isThreeLine = true' aligns leading and trailing widgets to the top vertically with the text.",
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  // Implement edit functionality
                },
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  // Implement delete functionality
                },
              ),
              IconButton(
                icon: Icon(Icons.check_circle),
                onPressed: () {
                  // Implement mark as done functionality
                },
              ),
            ],
          ),
          isThreeLine: true,
        ),
        Divider(height: 0),
      ],
    );
  }
}
