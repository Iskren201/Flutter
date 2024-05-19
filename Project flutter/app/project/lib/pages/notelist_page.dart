import 'package:flutter/material.dart';
import 'package:project/service/api_service.dart';
import 'notelistDone_page.dart';

class NoteList extends StatefulWidget {
  const NoteList({Key? key}) : super(key: key);

  @override
  State<NoteList> createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  bool _showDoneNotes = false;
  late Future<List<Task>> futureTasks;
  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    futureTasks = apiService.fetchTasks();
  }

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
                _showDoneNotes = !_showDoneNotes;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<Task>>(
              future: futureTasks,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No tasks available'));
                } else {
                  final tasks = snapshot.data!;
                  return ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      final task = tasks[index];
                      if (_showDoneNotes == task.status) {
                        return ListTile(
                          leading: CircleAvatar(child: Text(task.title[0])),
                          title: Text(task.title),
                          subtitle: Text(task.description),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.check_circle),
                                onPressed: () async {
                                  await apiService.updateTaskStatus(
                                      task.id, !task.status);
                                  setState(() {
                                    futureTasks = apiService.fetchTasks();
                                  });
                                },
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                  );
                }
              },
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              await apiService.addTask('New Task', 'Task Description');
              setState(() {
                futureTasks = apiService.fetchTasks();
              });
            },
            child: Text('Add Task'),
          ),
        ],
      ),
    );
  }
}
