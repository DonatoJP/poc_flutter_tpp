import 'dart:io';

class SocketService {
  RawDatagramSocket? socket;

  SocketService(this.socket);
}

class SocketServiceServer extends SocketService {
  SocketServiceServer(RawDatagramSocket socket) : super(socket);

  static Future<SocketServiceServer> createServer() async {
    return RawDatagramSocket.bind(InternetAddress.anyIPv4, 3030)
        .then((RawDatagramSocket socket) => SocketServiceServer(socket));
  }

  void startListening(Function(String) callback) {
    print('Listening on ${socket?.address.host}:${socket?.port}');
    socket?.listen((RawSocketEvent event) {
      Datagram? d = socket?.receive();
      if (d == null) return;

      String message = String.fromCharCodes(d.data).trim();
      print('Datagram from ${d.address.address}:${d.port}: $message');

      callback(message);
    });
  }

  void stopListening() {
    socket?.close();
  }
}

class SocketServiceClient extends SocketService {
  InternetAddress ip;
  int port;
  SocketServiceClient(String ip, this.port, RawDatagramSocket socket)
      : ip = InternetAddress(ip),
        super(socket);

  static Future<SocketServiceClient> createClient(ip, port) async {
    return RawDatagramSocket.bind(InternetAddress.anyIPv4, 0).then(
        (RawDatagramSocket socket) => SocketServiceClient(ip, port, socket));
  }

  send(String message) {
    return socket?.send(message.codeUnits, ip, port);
  }
}
