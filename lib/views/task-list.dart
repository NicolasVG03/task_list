import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TaskListPage extends StatelessWidget {

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void updateTask(String id, bool finished) {
    firestore.collection('tasks').doc(id).update({
      'finished': finished,
    });
  }

  void deleteTask(String id) {
    firestore.collection('tasks').doc(id).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: firestore
              .collection('tasks')
              //.where('finished', isEqualTo: false)
              .orderBy('name')
              .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                  return const Center(
                  child: CircularProgressIndicator(),
                );
              } 

              var tasks = snapshot.data!.docs;
              return ListView(
                children: tasks.map((task) => 

                  Dismissible(
                    key: Key(task.id),
                    onDismissed: (_) => deleteTask(task.id),
                    background: Container(
                      color: Colors.red,
                      child: const Icon(Icons.delete),
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 12),
                    ),
                    child: CheckboxListTile(
                      title: Text(task['name']),
                      onChanged: (value) => updateTask(task.id, value!),
                      value: task['finished'],
                      ),
                  )

                ).toList(),
              );
            },
          ),
      // ignore: prefer_const_constructors
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed('task-create'),
        child: const Icon(Icons.add),
      ),
    );
  }
}