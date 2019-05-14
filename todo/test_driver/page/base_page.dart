import 'package:flutter_driver/flutter_driver.dart';

abstract class BasePage {
  FlutterDriver _driver;

  BasePage(this._driver);

  FlutterDriver get driver => this._driver;

  Future<dynamic> waitToLoad();

  Future<void> enterTextField(String text, String key) async {
    await driver.tap(find.byValueKey(key));
    await driver.enterText(text);
  }
}