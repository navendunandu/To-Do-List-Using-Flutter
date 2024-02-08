import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
// import 'package:sqflite/sqflite.dart' as sql;

class ToDo extends StatefulWidget {
  const ToDo({super.key});

  @override
  State<ToDo> createState() => _ToDoState();
}

class _ToDoState extends State<ToDo> {
  List<Map<String, dynamic>> _todos = [];
  final _todoLIst = Hive.box('to_do_list');
  final TextEditingController _textController = TextEditingController();

  void initState() {
    super.initState();
    _refreshDetails();
  }

  Future<void> _addToDO(String todo) async {
    Map<String, dynamic> ToDo = {
      "title": todo,
      "complete": false,
    };
    await _todoLIst.add(ToDo);
    _refreshDetails();
  }

  void _refreshDetails() {
    final data = _todoLIst.keys.map((key) {
      final list = _todoLIst.get(key);
      return {"key": key, "title": list["title"], "complete": list["complete"]};
    }).toList();
    setState(() {
      _todos = data.reversed.toList();
      //print(_studs.length);
    });
    print(_todos);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: InputDecoration(labelText: 'Enter task'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    _addToDO(_textController.text);
                    _textController.clear();
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _todoLIst.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_todos[index]['title']),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
