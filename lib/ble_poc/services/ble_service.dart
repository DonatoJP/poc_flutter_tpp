import 'dart:async';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

class BleService {
  final flutterReactiveBle = FlutterReactiveBle();
  bool? isScanning;
  StreamSubscription? scanSubscription;

  Future<void> start(void Function(DiscoveredDevice) deviceCallback) async {
    isScanning = true;
    scanSubscription = flutterReactiveBle.scanForDevices(
        withServices: [Uuid.parse("bf27730d-860a-4e09-889c-2d8b6a9e0fe7")],
        scanMode: ScanMode.lowLatency).listen((device) {
      deviceCallback(device);
    }, onError: (error) {
      return;
    });
  }

  Future<void> cancel() async {
    if (isScanning ?? false) {
      isScanning = false;
      await scanSubscription!.cancel();
      print("Canceled suscription");
    }
  }

  bool getIsScanning() {
    return isScanning ?? false;
  }
}
