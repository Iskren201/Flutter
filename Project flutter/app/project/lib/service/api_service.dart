import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://localhost:3000';

  Future<List<Task>> fetchTasks() async {
    final response = await http.get(Uri.parse('$baseUrl/tasks'));
    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body)['tasks'];
      return body.map((task) => Task.fromJson(task)).toList();
    } else {
      throw Exception('Failed to load tasks');
    }
  }

  Future<Task> addTask(String title, String description) async {
    final response = await http.post(
      Uri.parse('$baseUrl/tasks'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'title': title, 'description': description}),
    );
    if (response.statusCode == 200) {
      return Task.fromJson(json.decode(response.body)['task']);
    } else {
      throw Exception('Failed to add task');
    }
  }

  Future<Task> updateTaskStatus(int id, bool status) async {
    final response = await http.put(
      Uri.parse('$baseUrl/tasks/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'status': status}),
    );
    if (response.statusCode == 200) {
      return Task.fromJson(json.decode(response.body)['task']);
    } else {
      throw Exception('Failed to update task status');
    }
  }
}

class Task {
  final int id;
  final String title;
  final String description;
  final bool status;

  Task(
      {required this.id,
      required this.title,
      required this.description,
      required this.status});

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      status: json['status'],
    );
  }
}
