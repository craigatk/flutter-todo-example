import 'package:jaguar_query/jaguar_query.dart';

import 'todo_record.dart';

class DatabaseMigrator {
  final Adapter _adapter;
  final TodoRecordBean _todoRecordBean;

  DatabaseMigrator(
    this._adapter,
    this._todoRecordBean,
  );

  Future<void> migrate() async {
    int currentVersion = await _adapter.connection.getVersion();

    if (currentVersion == null || currentVersion == 0) {
      await createInitialTables();
      await _adapter.connection.setVersion(1);
      currentVersion = 1;
    }
  }

  Future<void> createInitialTables() async {
    final st = Sql.create(_todoRecordBean.tableName, ifNotExists: false);
    st.addInt(_todoRecordBean.id.name, primary: true, autoIncrement: true, isNullable: false);
    st.addStr(_todoRecordBean.title.name, isNullable: false);
    st.addBool(_todoRecordBean.complete.name, isNullable: false);
    return _adapter.createTable(st);
  }
}
