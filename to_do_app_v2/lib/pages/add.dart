import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_app_v2/providers/todo_provider.dart';

class AddToDo extends ConsumerWidget {
  const AddToDo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController todoController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add To-Do"),
      ),
      body: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            // text field to add a new to do
            child: TextField(
              controller: todoController,
              decoration: const InputDecoration(
                labelText: "To-Do Task",
                border: OutlineInputBorder(),
              ),
            ),
          ),

          // button to add a new to do and pop the page
          TextButton(
              onPressed: () {
                ref.read(todoProvider.notifier).addTodo(todoController.text);
                Navigator.pop(context);
              },
              child: const Text("Add To-Do")),
        ]),
      ),
    );
  }
}
