import 'package:namer_app/generator/presentation/generator.dart';
import 'package:namer_app/favourites/presentation/favourites.dart';
import 'package:namer_app/ble_poc/ble_poc.dart';
import 'package:namer_app/ble_poc/services/ble_service.dart';
import 'package:stacked/stacked_annotations.dart';

@StackedApp(
  routes: [],
  dependencies: [
    LazySingleton(classType: BleService),
  ],
)
class AppSetup {}
