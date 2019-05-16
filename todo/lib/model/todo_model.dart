import 'package:scoped_model/scoped_model.dart';
import 'package:todo/database/todo_record.dart';

class TodoModel extends Model {
  final int _id;
  String _title;
  bool _complete;

  final TodoRecordBean _todoRecordBean;

  int get id => _id;

  String get title => _title;

  bool get complete => _complete;

  TodoModel(
    this._id,
    this._title,
    this._complete,
    this._todoRecordBean,
  );

  TodoModel.fromRecord(TodoRecord todoRecord, TodoRecordBean todoRecordBean)
      : this(
          todoRecord.id,
          todoRecord.title,
          todoRecord.complete,
          todoRecordBean,
        );

  void toggleComplete() {
    this._complete = !this._complete;

    _todoRecordBean.updateFields(_todoRecordBean.id.eq(id), {
      _todoRecordBean.complete.name: this._complete,
    });

    notifyListeners();
  }
}
