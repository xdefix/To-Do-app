class ToDo {
  final String id;
  final String todoText;
  final bool isDone;

  const ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  ToDo copyWith({String? id, String? todoText, bool? isDone}) {
    return ToDo(
      id: id ?? this.id,
      todoText: todoText ?? this.todoText,
      isDone: isDone ?? this.isDone,
    );
  }

  static List<ToDo> todoList() {
    return const [
      ToDo(id: '01', todoText: 'Morning Exercise', isDone: true),
      ToDo(id: '02', todoText: 'Buy Groceries', isDone: true),
      ToDo(id: '03', todoText: 'Check Emails'),
      ToDo(id: '04', todoText: 'Team Meeting'),
      ToDo(id: '05', todoText: 'Work on mobile apps for 2 hours'),
      ToDo(id: '06', todoText: 'Dinner with Jenny'),
    ];
  }
}