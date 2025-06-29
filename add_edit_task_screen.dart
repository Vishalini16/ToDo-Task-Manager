import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import '../models/task.dart';

class AddEditTaskScreen extends StatefulWidget {
  final Task? existingTask;

  AddEditTaskScreen({this.existingTask});

  @override
  _AddEditTaskScreenState createState() => _AddEditTaskScreenState();
}

class _AddEditTaskScreenState extends State<AddEditTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final titleCtrl = TextEditingController();
  final descCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.existingTask != null) {
      titleCtrl.text = widget.existingTask!.title;
      descCtrl.text = widget.existingTask!.description;
    }
  }

  void _saveTask() {
    if (_formKey.currentState!.validate()) {
      final provider = Provider.of<TaskProvider>(context, listen: false);
      final isEditing = widget.existingTask != null;

      final task = Task(
        id: isEditing ? widget.existingTask!.id : DateTime.now().toString(),
        title: titleCtrl.text,
        description: descCtrl.text,
        isCompleted: isEditing ? widget.existingTask!.isCompleted : false,
        dueDate: isEditing ? widget.existingTask!.dueDate : DateTime.now(),
      );

      isEditing ? provider.updateTask(task) : provider.addTask(task);

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.existingTask != null;

    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Edit Task' : 'Add Task')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: titleCtrl,
                decoration: InputDecoration(
                  labelText: "Title",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.title),
                ),
                validator: (value) =>
                    value == null || value.trim().isEmpty ? "Enter a title" : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: descCtrl,
                decoration: InputDecoration(
                  labelText: "Description",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.description),
                ),
                validator: (value) =>
                    value == null || value.trim().isEmpty ? "Enter a description" : null,
              ),
              SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _saveTask,
                icon: Icon(isEditing ? Icons.check : Icons.save),
                label: Text(isEditing ? "Update Task" : "Save Task"),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 48),
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}