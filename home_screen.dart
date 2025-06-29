import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../providers/task_provider.dart';
import '../widgets/task_tile.dart';
import 'add_edit_task_screen.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  final _searchCtrl = TextEditingController();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    Provider.of<TaskProvider>(context, listen: false).loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    final user = FirebaseAuth.instance.currentUser;

    List filteredTasks = taskProvider.searchTasks(_searchCtrl.text);
    if (_tabController.index == 1) {
      filteredTasks = filteredTasks.where((t) => t.isCompleted).toList();
    } else if (_tabController.index == 2) {
      filteredTasks = filteredTasks.where((t) => !t.isCompleted).toList();
    }

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(user?.photoURL ?? ''),
              radius: 16,
            ),
            SizedBox(width: 8),
            Text(user?.displayName ?? 'My Tasks'),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            tooltip: "Sign Out",
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => LoginScreen()),
                (route) => false,
              );
            },
          )
        ],
        bottom: TabBar(
          controller: _tabController,
          onTap: (_) => setState(() {}),
          tabs: const [
            Tab(text: "All"),
            Tab(text: "Completed"),
            Tab(text: "Pending"),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => AddEditTaskScreen()));
        },
        child: Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Provider.of<TaskProvider>(context, listen: false).loadTasks();
          setState(() {});
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                controller: _searchCtrl,
                decoration: InputDecoration(
                  hintText: "Search tasks...",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onChanged: (_) => setState(() {}),
              ),
            ),
            Expanded(
              child: filteredTasks.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.inbox, size: 60, color: Colors.grey),
                          SizedBox(height: 12),
                          Text("No tasks available",
                              style: TextStyle(fontSize: 16, color: Colors.grey)),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: filteredTasks.length,
                      itemBuilder: (context, index) =>
                          TaskTile(task: filteredTasks[index]),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
