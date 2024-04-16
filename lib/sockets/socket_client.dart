import 'dart:io';

import 'package:chat_app_sockets/controllers/socket_controller.dart';
import 'package:get/get.dart';

void clientSocket() {
  // Client Side Code...
  Socket.connect("192.168.1.36", 8080).then((socket) {
    final SocketController controller = Get.find<SocketController>();
    controller.updateClientSocket(socket);

    socket.listen((data) {
      controller.updateMsg(String.fromCharCodes(data).trim());
    }, onDone: () {
      socket.destroy();
      controller.updateClientStatus(false);
    });
  });
}
