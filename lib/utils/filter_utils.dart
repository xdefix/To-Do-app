import 'package:flutter_app/model/todo.dart';


bool searchQuery(ToDo todo, String query) {
  if (query.isEmpty) {
    return true;
  } else {
    return todo.todoText.toLowerCase().contains(query.toLowerCase());
  }
}

List<ToDo> filterTodos(List<ToDo> todosList, String query) {
  return todosList.where((todo) => searchQuery(todo, query)).toList();
}
