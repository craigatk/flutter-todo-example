import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:todo/model/app_model.dart';
import 'package:todo/page/home_page.dart';

final appModel = AppModel.empty();

void main({bool shouldLoadSampleData = false}) {
  appModel.initDB(shouldLoadSampleData);

  runApp(MyApp(
      appModel: appModel
  ));
}

class MyApp extends StatelessWidget {
  final AppModel appModel;

  const MyApp({Key key, this.appModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModel<AppModel>(
      model: appModel,
      child: ScopedModelDescendant<AppModel>(
        builder: (context, child, model) => MaterialApp(
          title: 'TODO',
          theme: new ThemeData(
            primarySwatch: Colors.teal,
          ),
          home: HomePage(),
        ),
      ),
    );
  }}

