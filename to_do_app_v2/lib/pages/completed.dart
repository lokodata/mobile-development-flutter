import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:to_do_app_v2/providers/todo_provider.dart';

import '../models/todo.dart';

class CompletedToDo extends ConsumerWidget {
  const CompletedToDo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // get the list of to do from the provider
    List<Todo> todos = ref.watch(todoProvider);

    // get the list of active to do
    List<Todo> completedTodos =
        todos.where((todo) => todo.completed == true).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("To Do App"),
      ),
      body: ListView.builder(
        itemCount: completedTodos.length,
        itemBuilder: (context, index) {
          return Slidable(
            // start slide to delete
            startActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) => ref
                      .watch(todoProvider.notifier)
                      .deleteTodo(completedTodos[index].todoId),
                  backgroundColor: Colors.red,
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  icon: Icons.delete,
                ),
              ],
            ),

            // list of all to do
            child: Container(
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: const BorderRadius.all(Radius.circular(20)),
              ),
              child: ListTile(
                title: Text(completedTodos[index].content),
              ),
            ),
          );
        },
      ),
    );
  }
}
