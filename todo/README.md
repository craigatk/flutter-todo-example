# Sample Todo app

This is a sample Todo app demonstrating some of the basics of Flutter.

## Technology

* Flutter
* SqlLite database
* [Scoped Model](https://medium.com/flutter-community/flutter-app-architecture-101-vanilla-scoped-model-bloc-7eff7b2baf7e) for state management
* [Jaguar ORM](https://github.com/Jaguar-dart/jaguar_orm) for database access
* Some unit tests
* Flutter driver integration tests

## Driver tests

This app includes [driver tests](https://flutter.dev/docs/cookbook/testing/integration/introduction)
that drive user-level tests again the app installed on an Android emulator. This allows
more thorough verification of the app's features, including storing/retrieving data from the app's
SqlLite database.

To run the driver tests, either execute the `driver.sh` shell script or run `flutter drive --target=test_driver/app.dart`

