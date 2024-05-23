import 'package:flutter/material.dart';
import 'package:project/service/api_service.dart';
import 'new_task_page.dart';

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

  Future<void> _refreshTasks() async {
    setState(() {
      futureTasks = apiService.fetchTasks();
    });
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
                futureTasks = apiService.fetchTasks();
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
                      if (_showDoneNotes == task.isDone) {
                        return ListTile(
                          leading: CircleAvatar(child: Text(task.title[0])),
                          title: Text(task.title),
                          subtitle: Text(task.description),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(task.isDone
                                    ? Icons.undo
                                    : Icons.check_circle),
                                onPressed: () async {
                                  await apiService.updateTaskStatus(
                                      task.id, !task.isDone);
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
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NewTaskPage()),
              );

              // If a new task was created, refresh the task list
              if (result == true) {
                _refreshTasks();
              }
            },
            child: Text('Add Task'),
          ),
        ],
      ),
    );
  }
}
