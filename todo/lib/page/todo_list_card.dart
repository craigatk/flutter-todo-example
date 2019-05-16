import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:todo/model/todo_model.dart';

class TodoListCard extends StatelessWidget {
  final _titleStyle = const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold);
  final _itemPadding = const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<TodoModel>(
      builder: (context, child, model) => Card(
            child: Padding(
              padding: _itemPadding,
              child: Row(
                children: [
                  Checkbox(
                    value: model.complete,
                    key: Key(model.complete
                        ? "todo_list_item_complete_${model.id}"
                        : "todo_list_item_not_complete_${model.id}"),
                  ),
                  Text(
                    "${model.title}",
                    key: Key("todo_list_item_title_${model.id}"),
                    style: _titleStyle,
                  ),
                ],
              ),
            ),
          ),
    );
  }
}
