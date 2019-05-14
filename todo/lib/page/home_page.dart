import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:todo/model/app_model.dart';
import 'package:todo/page/add_todo_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppModel>(
      builder: (context, child, model) => Scaffold(
            key: Key('home_page'),
            appBar: AppBar(
              title: Text("TODO Sample"),
            ),
            body: Center(
              child: Text("Home page"),
            ),
            floatingActionButton: FloatingActionButton(
              key: Key('go_to_add_todo_button'),
              onPressed: () =>
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AddTodoPage())),
              child: Icon(Icons.add),
            ),
          ),
    );
  }
}
