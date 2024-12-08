import 'package:flutter_app/model/todo.dart';

// The reusable search function that checks if a to-do item matches the query
bool searchQuery(ToDo todo, String query) {
  // If the query is empty, match all items
  if (query.isEmpty) {
    return true;
  } else {
    // Convert both the todo text and the query to lowercase for case-insensitive comparison
    return todo.todoText.toLowerCase().contains(query.toLowerCase());
  }
}

// The filtering function that applies the searchQuery to a list of to-dos
List<ToDo> filterTodos(List<ToDo> todosList, String query) {
  return todosList.where((todo) => searchQuery(todo, query)).toList();
}
