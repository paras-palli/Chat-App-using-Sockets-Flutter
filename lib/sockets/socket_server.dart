import 'dart:io';

import 'package:chat_app_sockets/controllers/socket_controller.dart';
import 'package:get/get.dart';

class Server {
  static ServerSocket? _server;
  // Server Side Code...
  void handleClient(Socket client) {
    final SocketController controller = Get.find<SocketController>();
    controller.updateServerSocket(client);

    client.listen((data) {
      controller.updateMsg(String.fromCharCodes(data).trim());
    }, onDone: () {
      controller.updateClientStatus(false);
      client.destroy();
    });
  }

  void listen() {
    if (_server == null) {
      try {
        // InternetAddress.anyIPv4
        ServerSocket.bind("192.168.1.36", 8080).then((ServerSocket server) {
          print("Server Started at ${server.address}:8080");
          _server = server;
          server.listen(handleClient);
        });
      } catch (ex) {
        print(ex);
      }
    }
  }
}
