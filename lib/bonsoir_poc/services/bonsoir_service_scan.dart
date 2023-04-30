import 'package:bonsoir/bonsoir.dart';

class BonsoirServiceScan {
  static String type = '_wonderful-service._tcp';
  static BonsoirDiscovery discovery = BonsoirDiscovery(type: type);

  Future<void> startScanning(Function(BonsoirService?) callback) async {
    // Future<void> startScanning() async {
    await discovery.ready;
    discovery.eventStream?.listen((BonsoirDiscoveryEvent event) {
      if (event.type == BonsoirDiscoveryEventType.discoveryServiceResolved) {
        print('Service found: ${event.service?.toJson()}');
        callback(event.service);
      } else if (event.type == BonsoirDiscoveryEventType.discoveryServiceLost) {
        print('Service lost: ${event.service?.toJson()}');
        callback(event.service);
      }
    });

    await discovery.start();
  }

  Future<void> stopScanning() async {
    await discovery.stop();
  }
}
