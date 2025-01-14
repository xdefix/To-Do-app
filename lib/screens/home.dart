import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; 
import '../model/todo.dart';
import '../constants/colors.dart';
import '../widgets/todo_item.dart';
import '../utils/filter_utils.dart';
import '../screens/settings_screen.dart';
import '../widgets/add_todo_bar.dart'; 
import '../widgets/user_icon.dart'; 
import '../widgets/settings_button.dart'; 
import '../widgets/language_toggle_button.dart'; 
import '../widgets/search_bar.dart' as custom;
import '../widgets/toggle_sort_button.dart'; 

class Home extends StatefulWidget {
  final VoidCallback onLocaleToggle; 

  const Home({Key? key, required this.onLocaleToggle}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<ToDo> todosList = ToDo.todoList();
  String _searchQuery = "";
  final _todoController = TextEditingController();
  String username = "User";
  bool isSortedByDate = true;  // Track whether it's sorted by date or name

  @override
  Widget build(BuildContext context) {
    // Filter todos based on search query
    List<ToDo> filteredTodos = filterTodos(todosList, _searchQuery);

    // Sort the list based on the current sorting order (date or content)
    if (isSortedByDate) {
      filteredTodos.sort((a, b) => b.id.compareTo(a.id));  
    } else {
      filteredTodos.sort((a, b) => a.todoText.toUpperCase().compareTo(b.todoText.toUpperCase()));  // Descending content sort
    }

    String welcomeMessage = AppLocalizations.of(context)!.welcomeMessage(username);

    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              children: [
                Text(
                  welcomeMessage,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                custom.SearchBar(
                  onSearchChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                ),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 50, bottom: 20),
                        child: Text(
                          AppLocalizations.of(context)!.all_todos,
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      if (filteredTodos.isEmpty)
                        Center(
                          child: Text(
                            AppLocalizations.of(context)!.no_todos,
                            style: const TextStyle(fontSize: 18, color: tdGrey),
                          ),
                        )
                      else
                        for (ToDo todo in filteredTodos)
                          ToDoItem(
                            todo: todo,
                            onToDoChanged: _handleToDoChange,
                            onDeleteItem: _deleteToDoItem,
                          ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: AddToDoBar(
              controller: _todoController,
              onAddToDo: (newToDo) {
                setState(() {
                  todosList = [...todosList, newToDo];
                });
              },
              hintText: AppLocalizations.of(context)!
                  .add_todo_hint,
            ),
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: tdBGColor,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(
            Icons.menu,
            color: tdBlack,
            size: 30,
          ),
          const UserIcon(),
          Row(
            children: [
              LanguageToggleButton(
                onPressed: widget.onLocaleToggle, 
              ),
              SettingsButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SettingsScreen(),
                    ),
                  );
                },
              ),
              ToggleSortButton( 
                isSortedByDate: isSortedByDate,
                onToggleSort: () {
                  setState(() {
                    isSortedByDate = !isSortedByDate;          
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _handleToDoChange(ToDo todo) {
    setState(() {
      final updatedTodo = todo.copyWith(isDone: !todo.isDone);
      final index = todosList.indexWhere((item) => item.id == todo.id);
      if (index != -1) {
        todosList[index] = updatedTodo;
      }
    });
  }

  void _deleteToDoItem(String id) {
    setState(() {
      todosList = todosList.where((item) => item.id != id).toList();
    });
  }
}
