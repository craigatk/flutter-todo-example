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
  final _buttonTextStyle = const TextStyle(fontSize: 20.0);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        key: Key('add_todo_page'),
        title: Text("Add New To-Do"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: ScopedModelDescendant<AppModel>(
          builder: (context, child, model) {
            return Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    key: Key('todo_title_input'),
                    decoration: InputDecoration(labelText: 'Todo title'),
                    controller: _titleController,
                    textCapitalization: TextCapitalization.sentences,
                    validator: (value) => value.isEmpty ? 'Please enter a title' : null,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15.0),
                    child: MaterialButton(
                      key: Key('add_todo_button'),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          model.addTodo(
                            _titleController.text,
                          );
                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        'Add',
                        style: _buttonTextStyle,
                      ),
                      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 40.0),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.teal, width: 3.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
