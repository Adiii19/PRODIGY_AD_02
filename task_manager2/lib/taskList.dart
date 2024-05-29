import 'dart:async';
import 'package:flutter/material.dart';
import 'package:task_manager2/models/model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'widgets/taskItem.dart';

class Tasklist extends StatefulWidget {
  Tasklist({super.key});

  @override
  State<Tasklist> createState() => _TasklistState();
}

class _TasklistState extends State<Tasklist> {
  final DatabaseReference databaseref = FirebaseDatabase.instance.ref().child('Tasklist');
  List<Task> loadedItems = [];
  
  late StreamSubscription _subscription;
  
  @override
  void initState() {
    super.initState();
    loadItems();
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  Future<void> loadItems() async {
    final url = Uri.https('task-manager-app-67b0c-default-rtdb.firebaseio.com', '/Tasklist.json');
    final response = await http.get(url);

    if (response.statusCode >= 400) {
      print('Failed to fetch data. Please try again.');
      return;
    }

    if (response.body == 'null') {
      print("Body null");
      setState(() {
        loadedItems = [];
      });
      return;
    }

    Map<String, dynamic>? data;
    try {
      data = json.decode(response.body) as Map<String, dynamic>?;
    } catch (e) {
      throw Exception('Failed to parse data. Please try again.');
    }

    if (data == null) {
      setState(() {
        loadedItems = [];
      });
      return;
    }

    final List<Task> tasks = data.entries.map((entry) {
      final taskData = entry.value as Map<String, dynamic>;
      taskData['id'] = entry.key; // Ensure the ID is included
      return Task.fromJson(taskData);
    }).toList();

    setState(() {
      loadedItems = tasks;
    });

    _subscription = databaseref.onChildAdded.listen((event) {
      final dynamic value = event.snapshot.value;
      if (value != null && value is Map<dynamic, dynamic>) {
        final newTask = Task.fromJson(Map<String, dynamic>.from(value)..['id'] = event.snapshot.key);
        setState(() {
          loadedItems.add(newTask);
        });
      }
    });

    _subscription = databaseref.onChildRemoved.listen((event) {
      setState(() {
        loadedItems.removeWhere((task) => task.id == event.snapshot.key);
      });
    });
  }

  Future<void> removeItem(Task task) async {
    var key = task.id;
    try {
      await databaseref.child(key).remove();
      setState(() {
        loadedItems.remove(task);
      });
    } catch (error) {
      print("Failed to remove task: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loadedItems.isEmpty) {
      return Center(child: Text("No tasks here. Kindly add your tasks", style: TextStyle(
        color: Colors.grey
      ),));
    }

    return ListView.builder(
      itemCount: loadedItems.length,
      itemBuilder: (ctx, index) {
        final task = loadedItems[index];
        return Dismissible(
          key: ValueKey(task.id),
          direction: DismissDirection.horizontal,
          onDismissed: (direction) {
            removeItem(task);
          },
          child: Taskitem(task),
          background: Container(color: Colors.red),
        );
      },
    );
  }
}
