import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:todo/model/app_model.dart';

class AddTodoPage extends StatefulWidget {
  @override
  AddTodoPageState createState() {
    return AddTodoPageState();
  }
}

class AddTodoPageState extends State<AddTodoPage> {
  final TextEditingController _titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        key: Key('add_todo_page'),
        title: Text("Add New Todo"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: ScopedModelDescendant<AppModel>(
          builder: (context, child, model) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextField(
                  key: Key('todo_title_input'),
                  decoration: InputDecoration(labelText: 'Todo title'),
                  controller: _titleController,
                ),
                RaisedButton(
                  key: Key('add_todo_button'),
                  onPressed: () {
                    model.addTodo(
                      _titleController.text,
                    );
                    Navigator.pop(context);
                  },
                  child: Text('Add Goal'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
