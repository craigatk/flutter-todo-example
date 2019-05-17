import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:todo/model/app_model.dart';
import 'package:todo/page/todo_list_card.dart';
import 'package:todo/model/todo_model.dart';

class TodoList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppModel>(
      builder: (context, child, model) => ListView(
            key: Key('todo_list'),
            shrinkWrap: true,
            children: model.sortedTodos.map((todo) => TodoListItem(model, todo)).toList(),
          ),
    );
  }
}

class TodoListItem extends StatelessWidget {
  final AppModel _appModel;
  final TodoModel _todoModel;

  TodoListItem(
    this._appModel,
    this._todoModel,
  );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      key: Key("todo_list_item_well_${this._todoModel.id}"),
      onTap: () => this._appModel.toggleComplete(this._todoModel.id),
      child: ScopedModel(
        model: this._todoModel,
        child: TodoListCard(),
      ),
    );
  }
}
