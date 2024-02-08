import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart' as sql;

class ToDo extends StatefulWidget {
  const ToDo({super.key});

  @override
  State<ToDo> createState() => _ToDoState();
}

class _ToDoState extends State<ToDo> {
  List<String> todos = [];

  void addTodo(String todo) {
    setState(() {
      todos.add(todo);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
      ),
      body: Column(
        children: <Widget>[
          TodoForm(addTodo),
          Expanded(
            child: TodoList(todos),
          ),
        ],
      ),
    );
  }
}

class TodoForm extends StatefulWidget {
  final Function(String) onSubmit;

  TodoForm(this.onSubmit);

  @override
  _TodoFormState createState() => _TodoFormState();
}

class _TodoFormState extends State<TodoForm> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Enter task'),
            ),
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              widget.onSubmit(_controller.text);
              _controller.clear();
            },
          ),
        ],
      ),
    );
  }
}

class TodoList extends StatelessWidget {
  final List<String> todos;

  TodoList(this.todos);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(todos[index]),
          // Add functionality to mark tasks as complete here
        );
      },
    );
  }
}
