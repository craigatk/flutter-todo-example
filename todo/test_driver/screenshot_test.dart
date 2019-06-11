import 'dart:io';

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
      await dataDriver.truncateTables();

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

    Future<void> _takeScreenshot(String filePath) async {
      List<int> imagePixels = await driver.screenshot();

      final screenshotImageFile = File(filePath);
      await screenshotImageFile.writeAsBytes(imagePixels);
    }

    test('create screenshots', () async {
      await dataDriver.insertTodo(TodoRecord.make("Clean up dishes", false));
      await dataDriver.insertTodo(TodoRecord.make("Mow lawn", false));
      await dataDriver.insertTodo(TodoRecord.make("Shop for groceries", false));
      await dataDriver.insertTodo(TodoRecord.make("Water garden", false));

      await _takeScreenshot("screenshots/android/home_screen.png");

      await homePage.goToAddTodoPage();

      await _takeScreenshot("screenshots/android/add_to_do_screen.png");
    });

  });
}
