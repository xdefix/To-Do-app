import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../model/todo.dart';

class AddToDoBar extends StatelessWidget {
  final TextEditingController controller;
  final Function(ToDo) onAddToDo;
  final String hintText;

  const AddToDoBar({
    Key? key,
    required this.controller,
    required this.onAddToDo,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
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
              controller: controller,
              decoration: InputDecoration(
                hintText: hintText, 
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
              if (controller.text.isNotEmpty) {
                final newToDo = ToDo(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  todoText: controller.text,
                );
                onAddToDo(newToDo);
                controller.clear();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: tdBlue,
              minimumSize: const Size(60, 60),
              elevation: 10,
            ),
          ),
        ),
      ],
    );
  }
}
