import 'package:bonsoir/bonsoir.dart';
import 'package:stacked/stacked.dart';
import 'package:namer_app/app.locator.dart';
import './services/bonsoir_service_broadcast.dart';
import './services/bonsoir_service_scan.dart';

import './services/socket_service.dart';

class BonsoirPocViewModel extends BaseViewModel {
  List<String> messages = [];
  List<BonsoirService> services = [];
  bool isBroadcasting = false;
  bool isScanning = false;
  int counter = 1;

  SocketServiceServer? serverService;

  final bonsoirBroadcastService = locator<BonsoirServiceBroadcast>();
  final bonsoirScanService = locator<BonsoirServiceScan>();

  List<String> getMessages() {
    return messages;
  }

  Future<void> startBroadcasting() async {
    isBroadcasting = true;
    messages.add("Broadcasting!");
    serverService = await SocketServiceServer.createServer();

    void callback(String message) {
      messages.add(message);
      notifyListeners();
    }

    serverService!.startListening(callback);
    await bonsoirBroadcastService.startBroadcasting();
    notifyListeners();
  }

  Future<void> stopBroadcasting() async {
    isBroadcasting = false;
    messages = [];
    serverService?.stopListening();
    await bonsoirBroadcastService.stopBroadcasting();
    notifyListeners();
  }

  Future<void> startScanning() async {
    isScanning = true;
    messages.add("Scanning!");

    void callback(BonsoirService? service) {
      if (service != null) {
        services.add(service);
      }

      notifyListeners();
    }

    await bonsoirScanService.startScanning(callback);
    notifyListeners();
  }

  Future<void> stopScanning() async {
    isScanning = false;
    messages = [];
    services = [];
    await bonsoirScanService.stopScanning();
    notifyListeners();
  }

  sendMessageTo(serviceIndex) async {
    print("Sending message to ${services[serviceIndex].name}");

    final service = services[serviceIndex] as ResolvedBonsoirService;

    SocketServiceClient client =
        await SocketServiceClient.createClient(service.ip, service.port);

    client.send('Sending message $counter\n');
    counter++;
  }
}
