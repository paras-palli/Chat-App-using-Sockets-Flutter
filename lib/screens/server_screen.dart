import 'package:chat_app_sockets/controllers/socket_controller.dart';
import 'package:chat_app_sockets/sockets/socket_server.dart';
import 'package:chat_app_sockets/widgets/chatbubble.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ServerScreen extends StatefulWidget {
  const ServerScreen({super.key});

  @override
  State<ServerScreen> createState() => _ServerScreenState();
}

class _ServerScreenState extends State<ServerScreen> {
  final TextEditingController sendMsgControlller = TextEditingController();

  @override
  void initState() {
    Server().listen();
    super.initState();
  }

  @override
  void dispose() {
    final SocketController controller = Get.find<SocketController>();
    controller.getClientSocket?.destroy();
    controller.updateClientStatus(false);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Server Socket"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: GetBuilder(
            init: SocketController(),
            builder: (SocketController controller) {
              if (controller.isServerConnected == false) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.blueAccent,
                  ),
                );
              }

              return Column(
                children: [
                  Text(
                    "Server Hosted to: ${controller.getServerSocket?.address}:${controller.getServerSocket?.port}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Expanded(
                    child: ListView.builder(
                      itemCount: controller.getMsgs.length,
                      itemBuilder: (context, index) {
                        return ChatBubble(
                          txt: controller.getMsgs[index],
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      Flexible(
                        child: TextField(
                          controller: sendMsgControlller,
                          decoration: const InputDecoration(
                            hintText: "Send Message",
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      IconButton(
                        onPressed: () {
                          controller
                              .sendServerMsg(sendMsgControlller.text.trim());
                          sendMsgControlller.clear();
                        },
                        icon: const Icon(Icons.send),
                      ),
                    ],
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
