import 'package:flutter/material.dart';
import '../models/task.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import '../screens/add_edit_task_screen.dart';

class TaskTile extends StatelessWidget {
  final Task task;

  TaskTile({required this.task});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TaskProvider>(context, listen: false);

    return Dismissible(
      key: Key(task.id),
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Icon(Icons.delete_forever, color: Colors.white),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (_) async {
        return await showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text("Delete Task"),
            content: Text("Are you sure you want to delete '${task.title}'?"),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context, false), child: Text("Cancel")),
              TextButton(onPressed: () => Navigator.pop(context, true), child: Text("Delete")),
            ],
          ),
        );
      },
      onDismissed: (_) {
        provider.deleteTask(task.id);
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        elevation: 3,
        child: ListTile(
          tileColor: task.isCompleted ? Colors.green.shade50 : Colors.blue.shade50,
          title: Text(
            task.title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              decoration: task.isCompleted ? TextDecoration.lineThrough : null,
            ),
          ),
          subtitle: Text(task.description),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Checkbox(
                value: task.isCompleted,
                onChanged: (_) => provider.toggleComplete(task.id),
              ),
              IconButton(
                icon: Icon(Icons.edit, color: Colors.blue),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AddEditTaskScreen(existingTask: task),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
