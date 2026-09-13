import 'package:flutter/material.dart';
import 'package:flutter_app_cha/controllers/task_controller.dart';
import 'package:flutter_app_cha/models/task.dart';
import 'package:flutter_app_cha/views/add_task_page.dart';

class HomePage extends StatefulWidget {
  final TaskController taskController;

  const HomePage({super.key, required this.taskController});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Task Manager'),
        elevation: 0,
        backgroundColor: Colors.blue.shade700,
      ),
      body: SafeArea(
        child: Column(
          children: [
            /// Summary Section
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.blue.shade50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildSummaryCard(
                    label: 'Total Tasks',
                    count: widget.taskController.totalCount,
                    color: Colors.blue,
                  ),
                  _buildSummaryCard(
                    label: 'Completed',
                    count: widget.taskController.completedCount,
                    color: Colors.green,
                  ),
                  _buildSummaryCard(
                    label: 'Pending',
                    count: widget.taskController.pendingCount,
                    color: Colors.orange,
                  ),
                ],
              ),
            ),

            /// Add New Task Button
            Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton.icon(
                onPressed: () async {
                  await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => AddTaskPage(
                        taskController: widget.taskController,
                      ),
                    ),
                  );
                  setState(() {}); // Refresh UI after returning
                },
                icon: const Icon(Icons.add),
                label: const Text('Add New Task'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade700,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
              ),
            ),

            /// Task List
            Expanded(
              child: widget.taskController.tasks.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.task_alt_outlined,
                            size: 64,
                            color: Colors.grey.shade300,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No tasks yet!',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Tap "Add New Task" to get started',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: widget.taskController.tasks.length,
                      itemBuilder: (context, index) {
                        final task = widget.taskController.tasks[index];
                        return _buildTaskCard(context, task, index);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build a summary card (Total, Completed, Pending)
  Widget _buildSummaryCard({
    required String label,
    required int count,
    required Color color,
  }) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Text(
            count.toString(),
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: Colors.grey.shade700,
          ),
        ),
      ],
    );
  }

  /// Build a task card with title, category, priority, and action buttons
  Widget _buildTaskCard(BuildContext context, Task task, int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Task Title and Status
            Row(
              children: [
                Expanded(
                  child: Text(
                    task.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      decoration: task.completed
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                      color: task.completed ? Colors.grey : Colors.black,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: task.completed ? Colors.green.shade100 : Colors.orange.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        task.completed ? Icons.check_circle : Icons.schedule,
                        size: 16,
                        color: task.completed ? Colors.green : Colors.orange,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        task.completed ? 'Completed' : 'Pending',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: task.completed ? Colors.green : Colors.orange,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            /// Category and Priority
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Icon(Icons.label_outline, size: 16, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                        task.category,
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _getPriorityColor(task.priority).withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    task.priority,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: _getPriorityColor(task.priority),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            /// Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton.icon(
                  onPressed: () {
                    setState(() {
                      widget.taskController.toggleStatus(index);
                    });
                  },
                  icon: Icon(
                    task.completed ? Icons.undo : Icons.check,
                    size: 16,
                  ),
                  label: Text(
                    task.completed ? 'Pending' : 'Complete',
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.blue,
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: () {
                    _showDeleteConfirmation(context, index);
                  },
                  icon: const Icon(Icons.delete_outline, size: 16),
                  label: const Text('Delete'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade600,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Show delete confirmation dialog
  void _showDeleteConfirmation(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Task?'),
          content: const Text('This action cannot be undone.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  widget.taskController.deleteTask(index);
                });
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Task deleted'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade600,
              ),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  /// Get color based on priority level
  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'high':
        return Colors.red;
      case 'medium':
        return Colors.amber;
      case 'low':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
