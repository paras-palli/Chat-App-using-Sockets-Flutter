import 'package:chat_app_sockets/screens/client_screen.dart';
import 'package:chat_app_sockets/screens/server_screen.dart';
import 'package:chat_app_sockets/controllers/socket_controller.dart';
import 'package:chat_app_sockets/sockets/socket_client.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: BindingsBuilder(() {
        Get.lazyPut(() => SocketController());
      }),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Chat App using Sockets"),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  child: const Text("Client"),
                  onPressed: () {
                    Get.to(const ClientScreen());
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  child: const Text("Server"),
                  onPressed: () {
                    Get.to(const ServerScreen());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
