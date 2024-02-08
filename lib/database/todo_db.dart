import 'package:sqflite/sqflite.dart';
import 'package:to_do_list/database/database_service.dart';
import 'package:to_do_list/model/todo.dart';

class TodoDB {
  final tableName = 'todos';

  Future<void> createTable(Database database) async {
    await database.execute("""CREATE TABLE IF NOT EXISTS $tableName (
      "id" INTEGER NOT NULL,
      "title" TEXT NOT NULL,
      "created_at" INTEGER NOT NULL DEFAULT (cast(strftime('%s', 'now') as int)),
      "updated_at" INTEGER,
      PRIMARY KEY("id" AUTOINCREMENT)
      ):""");
  }

  Future<int> create({required String title}) async {
    final database = await DatabaseService().database;
    return await database.rawInsert(
      '''INSERT INTO $tableName (title, created_at) VALUES(?,?)''',
      [title, DateTime.now().microsecondsSinceEpoch],
    );
  }

  // Future<List<Todo>> fetchAll() async {
  //   final database = await DatabaseService().database;
  //   final todos = await database.rawQuery(
  //       '''SEKECT * from $tableName ORDER BY COALESCE(updated_at, created_at)''');
  //   return todos.map((todo) => Todo.fromSqfliteDatabase(todo).toList());
  // }
}
