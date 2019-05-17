import 'package:mockito/mockito.dart';
import "package:test/test.dart";
import 'package:todo/database/todo_record.dart';
import 'package:todo/model/app_model.dart';

import '../mock_beans.dart';

void main() {
  test("should sort completed todos to the end of the list", () async {
    final openTodo1 = TodoRecord.make("open1", false);
    openTodo1.id = 1;
    final openTodo2 = TodoRecord.make("open2", false);
    openTodo2.id = 2;
    final completeTodo1 = TodoRecord.make("complete1", true);
    completeTodo1.id = 3;
    final completeTodo2 = TodoRecord.make("complete2", true);
    completeTodo2.id = 4;

    final mockTodoRecordBean = MockTodoRecordBean();

    final appModel = AppModel(mockTodoRecordBean);

    when(mockTodoRecordBean.getAll()).thenAnswer((_) => Future.value([
          completeTodo1,
          openTodo1,
          completeTodo2,
          openTodo2,
        ]));

    await appModel.loadDataFromDB();

    final sortedTodos = appModel.sortedTodos;

    expect(sortedTodos[0].title, openTodo1.title);
    expect(sortedTodos[1].title, openTodo2.title);
    expect(sortedTodos[2].title, completeTodo1.title);
    expect(sortedTodos[3].title, completeTodo2.title);
  });
}
