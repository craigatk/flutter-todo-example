import 'package:scoped_model/scoped_model.dart';
import 'package:todo/database/todo_record.dart';

class TodoModel extends Model {
  final int _id;
  String _title;
  bool _complete;

  int get id => _id;
  String get title => _title;
  bool get complete => _complete;

  TodoModel(
    this._id,
    this._title,
    this._complete,
  );

  TodoModel.fromRecord(TodoRecord todoRecord)
      : this(
          todoRecord.id,
          todoRecord.title,
          todoRecord.complete,
        );

  void toggleComplete() {
    this._complete = !this._complete;

    notifyListeners();
  }
}
