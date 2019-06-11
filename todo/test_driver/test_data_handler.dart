import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';
import 'package:todo/database/database.dart';
import 'package:todo/database/todo_record.dart';
import 'package:todo/main.dart' as app;
import 'dart:convert';

class TestDataHandler {
  SqfliteAdapter _adapter;
  TodoRecordBean _todoRecordBean;

  Future<SqfliteAdapter> _setup() async {
    if (_adapter == null) {
      _adapter = await DBProvider.db.adapter;
      _todoRecordBean = TodoRecordBean(_adapter);
    }

    return _adapter;
  }

  Future<String> dataHandler(String message) async {
    await _setup();

    if (message.startsWith("insert_todo")) {
      return _handleInsertTodo(message);
    } else if (message.startsWith("find_todo_by_title")) {
      return _handleFindTodoByTitle(message);
    } else if (message == "truncate_tables") {
      return _handleTruncateTables();
    } else {
      return "invalid message $message";
    }
  }

  Future<String> _handleInsertTodo(String message) async {
    final todoJson = message.split("%%").last;
    final record = TodoRecord.fromJson(json.decode(todoJson));

    final recordId = await _todoRecordBean.insert(record);

    await _reloadAppData();

    return recordId.toString();
  }

  Future<String> _handleFindTodoByTitle(String message) async {
    String title = message.split("%%").last;
    final record = await _todoRecordBean.findOneWhere(_todoRecordBean.title.eq(title));

    return record != null ? json.encode(record) : "not_found";
  }

  Future<void> _reloadAppData() async {
    await app.appModel.loadDataFromDB();
  }

  Future<String> _handleTruncateTables() async {
    await this._todoRecordBean.removeAll();

    await _reloadAppData();

    return "tables_trucated";
  }
}
