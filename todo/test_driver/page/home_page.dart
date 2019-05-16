import 'package:flutter_driver/flutter_driver.dart';

import 'add_todo_page.dart';
import 'base_page.dart';

class HomePage extends BasePage {
  HomePage(FlutterDriver driver) : super(driver);

  @override
  Future<dynamic> waitToLoad() async => driver.waitFor(
        find.byValueKey('home_page_loaded'),
        timeout: Duration(seconds: 30),
      );

  Future<String> getTodoListItemTitle(String id) async =>
      driver.getText(find.byValueKey("todo_list_item_title_$id"));

  Future<AddTodoPage> goToAddTodoPage() async {
    await driver.tap(find.byValueKey('go_to_add_todo_button'), timeout: Duration(seconds: 30));

    final addTodoPage = AddTodoPage(driver);
    await addTodoPage.waitToLoad();

    return addTodoPage;
  }

  Future<void> toggleTodoComplete(String id) async {
    await driver.tap(find.byValueKey("todo_list_item_well_$id"), timeout: Duration(seconds: 30));
  }

  Future<void> waitForTodoMarkedComplete(String id) async {
    await driver.waitFor(find.byValueKey("todo_list_item_complete_$id"));
  }

  Future<void> waitForTodoMarkedNotComplete(String id) async {
    await driver.waitFor(find.byValueKey("todo_list_item_not_complete_$id"));
  }
}
