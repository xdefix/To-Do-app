import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../model/todo.dart';
import '../constants/colors.dart';
import '../widgets/todo_item.dart';
import '../utils/filter_utils.dart';
import '../screens/settings_screen.dart';

class Home extends StatefulWidget {
  final void Function(Locale locale) onLocaleChange;

  const Home({Key? key, required this.onLocaleChange}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<ToDo> todosList = ToDo.todoList();
  String _searchQuery = ""; 
  final _todoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<ToDo> filteredTodos = filterTodos(todosList, _searchQuery); 

    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              children: [
                searchBox(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 50, bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.all_todos, 
                              style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.language, color: tdBlue),
                              onPressed: () {
                                Locale newLocale = Localizations.localeOf(context).languageCode == 'en'
                                    ? const Locale('bg')
                                    : const Locale('en');
                                widget.onLocaleChange(newLocale); 
                              },
                            ),
                          ],
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
                        for (ToDo todo in filteredTodos.reversed)
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
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 20, right: 20, left: 20),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 0.0),
                          blurRadius: 10.0,
                          spreadRadius: 0.0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: _todoController,
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.add_todo_hint,  
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 20, right: 20),
                  child: ElevatedButton(
                    child: const Text(
                      '+',
                      style: TextStyle(fontSize: 40),
                    ),
                    onPressed: () {
                      _addToDoItem(_todoController.text);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: tdBlue,
                      minimumSize: const Size(60, 60),
                      elevation: 10,
                    ),
                  ),
                ),
              ],
            ),
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

  void _addToDoItem(String toDo) {
    if (toDo.isEmpty) return;

    setState(() {
      todosList = [
        ...todosList,
        ToDo(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          todoText: toDo,
        ),
      ];
    });
    _todoController.clear();
  }

  Widget searchBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(0),
          prefixIcon: const Icon(
            Icons.search,
            color: tdBlack,
            size: 20,
          ),
          prefixIconConstraints: const BoxConstraints(
            maxHeight: 20,
            minWidth: 25,
          ),
          border: InputBorder.none,
          hintText: AppLocalizations.of(context)!.search_hint,
        ),
        onChanged: (value) {
          setState(() {
            _searchQuery = value; 
          });
        },
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
          Container(
            height: 40,
            width: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: const Image(image: AssetImage('assets/images/avatar.jpg')),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.settings, color: tdBlue),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsScreen(), 
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}