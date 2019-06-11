import 'package:flutter_driver/flutter_driver.dart';

import 'base_page.dart';
import 'home_page.dart';

class AddTodoPage extends BasePage {
  AddTodoPage(FlutterDriver driver) : super(driver);

  @override
  Future<dynamic> waitToLoad() async => driver.waitFor(find.byValueKey('add_todo_page'));

  Future<void> enterTitle(String title) async => enterTextField(title, 'todo_title_input');

  Future<HomePage> clickAddTodoButton() async {
    await driver.tap(find.byValueKey('add_todo_button'));

    final homePage = HomePage(driver);
    await homePage.waitToLoad();

    return homePage;
  }

  Future<void> clickAddTodoButtonFailure() async {
    await driver.tap(find.byValueKey('add_todo_button'));

    await waitToLoad();
  }
}
