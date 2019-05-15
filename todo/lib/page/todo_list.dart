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
            children: model.todos
                .map((todo) => ScopedModel(
                      model: todo,
                      child: TodoListItem(),
                    ))
                .toList(),
          ),
    );
  }
}

class TodoListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<TodoModel>(
      builder: (context, child, model) => InkWell(
            key: Key("todo_list_item_well_${model.id}"),
            onTap: () => model.toggleComplete(),
            child: TodoListCard(),
          ),
    );
  }
}
