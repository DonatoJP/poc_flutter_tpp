import 'package:bonsoir/bonsoir.dart';

class BonsoirServiceBroadcast {
  static BonsoirService srvc = BonsoirService(
    name: 'My wonderful service', // Put your service name here.
    type:
        '_wonderful-service._tcp', // Put your service type here. Syntax : _ServiceType._TransportProtocolName. (see http://wiki.ros.org/zeroconf/Tutorials/Understanding%20Zeroconf%20Service%20Types).
    port: 3030, // Put your service port here.
  );

  static BonsoirBroadcast broadcast = BonsoirBroadcast(service: srvc);

  Future<void> startBroadcasting() async {
    BonsoirBroadcast broadcast = BonsoirBroadcast(service: srvc);
    await broadcast.ready;
    await broadcast.start();
  }

  Future<void> stopBroadcasting() async {
    await broadcast.stop();
  }
}
