import 'package:scoped_model/scoped_model.dart';
import 'package:todo/database/todo_record.dart';

class TodoModel extends Model {
  final int _id;
  String _title;
  bool _complete;

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
}
