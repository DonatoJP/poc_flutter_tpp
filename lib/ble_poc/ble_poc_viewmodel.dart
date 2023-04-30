import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:namer_app/app.locator.dart';
import 'package:stacked/stacked.dart';
import './services/ble_service.dart';

class BlePocViewModel extends BaseViewModel {
  List<String> devices = [];
  final bleService = locator<BleService>();

  Future<void> startDetectingDevices() async {
    // Callback to add device info into devices list
    void saveDeviceInfo(DiscoveredDevice device) {
      if (!devices
          .contains("${device.name} ${device.id} ${device.serviceUuids}")) {
        devices.add("${device.name} ${device.id} ${device.serviceUuids}");
        notifyListeners();
      }
    }

    return bleService.start(saveDeviceInfo);
  }

  Future<void> stopDetectingDevices() async {
    await bleService.cancel();
    notifyListeners();
  }

  bool getIsScanning() {
    return bleService.getIsScanning();
  }

  List<String> getDevicesList() {
    return devices;
  }
}
