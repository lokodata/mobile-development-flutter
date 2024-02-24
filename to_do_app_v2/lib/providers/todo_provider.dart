import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_app_v2/models/todo.dart';

final todoProvider = StateNotifierProvider<TodoListNotifier, List<Todo>>((ref) {
  return TodoListNotifier();
});

class TodoListNotifier extends StateNotifier<List<Todo>> {
  TodoListNotifier() : super([]);

  // add a new to do
  void addTodo(String content) {
    state = [
      ...state,
      Todo(
        todoId: state.isEmpty ? 0 : state[state.length - 1].todoId + 1,
        content: content,
        completed: false,
      )
    ];
  }

  // set complete to true
  void completeTodo(int id) {
    state = [
      for (final todo in state)
        if (todo.todoId == id)
          Todo(
            todoId: todo.todoId,
            content: todo.content,
            completed: true,
          )
        else
          todo
    ];
  }

  // delete a to do
  void deleteTodo(int id) {
    state = state.where((todo) => todo.todoId != id).toList();
  }
}
