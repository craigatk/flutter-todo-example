import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
import 'package:todo/database/todo_record.dart';

import 'data_driver.dart';
import 'page/home_page.dart';

void main() {
  group("Todo app", () {
    FlutterDriver driver;
    DataDriver dataDriver;
    HomePage homePage;

    // Connect to the Flutter driver before running any tests
    setUpAll(() async {
      driver = await FlutterDriver.connect();
      dataDriver = DataDriver(driver);
      homePage = HomePage(driver);
      await homePage.waitToLoad();
    });

    setUp(() async {
      await homePage.waitToLoad();
    });

    tearDown(() async {
      await dataDriver.truncateTables();
    });

    tearDownAll(() async {
      if (driver != null) {
        await driver.close();
      }
    });

    test('can view todos on home page', () async {
      final title1 = "Todo title 1";
      final todoId1 = await dataDriver.insertTodo(TodoRecord.make(title1, false));
      final title2 = "Todo title 2";
      final todoId2 = await dataDriver.insertTodo(TodoRecord.make(title2, false));

      final title1OnHomePage = await homePage.getTodoListItemTitle(todoId1);
      expect(title1OnHomePage, title1);

      final title2OnHomePage = await homePage.getTodoListItemTitle(todoId2);
      expect(title2OnHomePage, title2);
    });

    test('can add todo', () async {
      final title = "Here is a newtodo item to complete";

      final addTodoPage = await homePage.goToAddTodoPage();

      await addTodoPage.enterTitle(title);

      await addTodoPage.clickAddTodoButton();

      final todoRecord = await dataDriver.findTodoByTitle(title);

      expect(todoRecord.title, title);
    });

    test('can toggle whether a is complete', () async {
      final title = "Todo to complete";
      final todoId = await dataDriver.insertTodo(TodoRecord.make(title, false));

      await homePage.waitForTodoMarkedNotComplete(todoId);

      await homePage.toggleTodoComplete(todoId);

      await homePage.waitForTodoMarkedComplete(todoId);

      final todoRecordShouldBeComplete = await dataDriver.findTodoByTitle(title);
      expect(todoRecordShouldBeComplete.complete, true);

      await homePage.toggleTodoComplete(todoId);

      await homePage.waitForTodoMarkedNotComplete(todoId);

      final todoRecordShouldNotBeComplete = await dataDriver.findTodoByTitle(title);
      expect(todoRecordShouldNotBeComplete.complete, false);
    });

    test('when adding todo the title must not be empty', () async {
      final addTodoPage = await homePage.goToAddTodoPage();

      await addTodoPage.clickAddTodoButtonFailure();

      final todoRecord = await dataDriver.findTodoByTitle("");

      expect(todoRecord, null);

      await driver.tap(find.pageBack());
    });
  });
}
