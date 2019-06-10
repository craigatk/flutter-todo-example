import 'package:flutter_driver/driver_extension.dart';
import 'package:todo/main.dart' as app;
import 'test_data_handler.dart';

void main() {
  enableFlutterDriverExtension(handler: TestDataHandler().dataHandler);

  app.main();
}
