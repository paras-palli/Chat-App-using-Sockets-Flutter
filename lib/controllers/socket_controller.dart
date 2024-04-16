import 'dart:io';

import 'package:get/get.dart';

class SocketController extends GetxController implements GetxService {
  List<String> msgList = ["Hii"];
  bool isClientConnected = false;
  bool isServerConnected = false;

  Socket? clientSocket;
  Socket? serverSocket;

  void updateMsg(String msg) {
    msgList.add(msg);
    update();
  }

  List<String> get getMsgs => msgList;

  // Client Sockets Services...
  void updateClientSocket(Socket socket) {
    clientSocket = socket;
    isClientConnected = true;
    update();
  }

  Socket? get getClientSocket => clientSocket;

  void updateClientStatus(bool status) {
    isClientConnected = status;
    update();
  }

  void sendClientMsg(String msg) {
    clientSocket?.write(msg);
    msgList.add(msg);
    update();
  }

  // Server Sockets Services...
  void updateServerSocket(Socket socket) {
    serverSocket = socket;
    isServerConnected = true;
    update();
  }

  Socket? get getServerSocket => clientSocket;

  void updateServerStatus(bool status) {
    isServerConnected = status;
    update();
  }

  void sendServerMsg(String msg) {
    serverSocket?.write(msg);
    msgList.add(msg);
    update();
  }
}
