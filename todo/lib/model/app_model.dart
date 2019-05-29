import 'package:scoped_model/scoped_model.dart';
import 'package:todo/database/database.dart';
import 'package:todo/database/database_migrator.dart';
import 'package:todo/database/todo_record.dart';
import 'package:todo/model/todo_model.dart';

class AppModel extends Model {
  List<TodoModel> _todos = [];

  TodoRecordBean _todoRecordBean;

  bool _loaded = false;

  List<TodoModel> get todos => _todos;

  List<TodoModel> get sortedTodos => _todos.toList()..sort((a, b) => a.compareTo(b));

  bool get loaded => _loaded;

  AppModel(this._todoRecordBean);

  AppModel.empty();

  Future<void> initDB(bool shouldLoadSampleData) async {
    final adapter = await DBProvider.db.adapter;

    this._todoRecordBean = TodoRecordBean(adapter);

    await DatabaseMigrator(adapter, _todoRecordBean).migrate();

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
              _todoRecordBean,
            ))
        .toList();

    this._loaded = true;

    notifyListeners();
  }

  Future<int> addTodo(String title) async {
    final record = TodoRecord.make(title, false);

    final id = await _todoRecordBean.insert(record);
    record.id = id;

    this._todos.add(
          TodoModel.fromRecord(
            record,
            this._todoRecordBean,
          ),
        );

    notifyListeners();

    return id;
  }

  void toggleComplete(int todoId) {
    this._todos.firstWhere((todo) => todo.id == todoId).toggleComplete();

    notifyListeners();
  }
}
