import 'dart:convert';

import 'package:flutter_driver/flutter_driver.dart';
import 'package:todo/database/todo_record.dart';

class DataDriver {
  FlutterDriver _driver;

  DataDriver(this._driver);

  Future<void> truncateTables() async => _driver.requestData("truncate_tables");

  Future<TodoRecord> findTodoByTitle(String title) async {
    final recordJson = await _driver.requestData("find_todo_by_title%%$title");
    return recordJson != "not_found" ? TodoRecord.fromJson(json.decode(recordJson)) : null;
  }

  Future<String> insertTodo(TodoRecord record) async {
    final recordJson = json.encode(record.toJson());

    return _driver.requestData("insert_todo%%$recordJson");
  }
}