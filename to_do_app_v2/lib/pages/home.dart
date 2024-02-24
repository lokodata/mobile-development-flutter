import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:to_do_app_v2/pages/add.dart';
import 'package:to_do_app_v2/pages/completed.dart';
import 'package:to_do_app_v2/providers/todo_provider.dart';

import '../models/todo.dart';

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // get the list of to do from the provider
    List<Todo> todos = ref.watch(todoProvider);

    // get the list of active to do
    List<Todo> activeTodos =
        todos.where((todo) => todo.completed == false).toList();

    // get the list of active to do
    List<Todo> completedTodos =
        todos.where((todo) => todo.completed == true).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("To-Do App"),
      ),
      body: ListView.builder(
        itemCount: activeTodos.length + 1,
        itemBuilder: (context, index) {
          if (activeTodos.isEmpty) {
            return const Padding(
              padding: EdgeInsets.only(top: 300),
              child: Center(
                child: Text("Add a Todo using the button below"),
              ),
            );
          }
          // if there are no active to do, show a button to navigate to completed to do
          if (index == activeTodos.length) {
            // if there are no completed to do, show nothing
            if (completedTodos.isEmpty) {
              return Container();

              // if there are completed to do, show a button to navigate to completed to do
            } else {
              return Center(
                child: TextButton(
                  child: const Text("Completed Todos"),
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const CompletedToDo(),
                    ),
                  ),
                ),
              );
            }

            // if there are active to do, show the list of active to do
          } else {
            return Slidable(
              // start slide to delete
              startActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) =>
                        ref.watch(todoProvider.notifier).deleteTodo(index),
                    backgroundColor: Colors.red,
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    icon: Icons.delete,
                  ),
                ],
              ),

              // end slide to complete
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) => ref
                        .watch(todoProvider.notifier)
                        .completeTodo(activeTodos[index].todoId),
                    backgroundColor: Colors.green,
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    icon: Icons.check,
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
                  title: Text(activeTodos[index].content),
                ),
              ),
            );
          }
        },
      ),

      // floating button to navigate to add page and add a to do
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddToDo(),
            ),
          );
        },
        tooltip: 'Add To-Do',
        backgroundColor: Colors.black,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
