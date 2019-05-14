import 'package:scoped_model/scoped_model.dart';
import 'package:todo/database/database.dart';
import 'package:todo/database/todo_record.dart';
import 'package:todo/model/todo_model.dart';

class AppModel extends Model {
  List<TodoModel> _todos = [];

  TodoRecordBean _todoRecordBean;

  List<TodoModel> get todos => _todos;

  AppModel.empty();

  Future<void> initDB(bool shouldLoadSampleData) async {
    final adapter = await DBProvider.db.adapter;

    this._todoRecordBean = TodoRecordBean(adapter);

    final currentVersion = await adapter.connection.getVersion();

    if (currentVersion == null || currentVersion == 0) {
      this._todoRecordBean.createTable();
      await adapter.connection.setVersion(1);
    }

    if (shouldLoadSampleData) {
      await this._loadSampleData();
    }

    this.loadDataFromDB();
  }

  Future<void> _loadSampleData() async {}

  Future<void> loadDataFromDB() async {
    final allRecords = await _todoRecordBean.getAll() ?? [];

    this._todos = allRecords
        .map((todoRecord) => TodoModel.fromRecord(
              todoRecord,
            ))
        .toList();

    notifyListeners();
  }

  Future<int> addTodo(String title) async {
    final record = TodoRecord.make(title, false);

    final id = await _todoRecordBean.insert(record);
    record.id = id;

    this._todos.add(
          TodoModel.fromRecord(
            record,
          ),
        );
    notifyListeners();
    return id;
  }
}
