import 'package:chat_app_sockets/controllers/socket_controller.dart';
import 'package:chat_app_sockets/sockets/socket_client.dart';
import 'package:chat_app_sockets/widgets/chatbubble.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClientScreen extends StatefulWidget {
  const ClientScreen({super.key});

  @override
  State<ClientScreen> createState() => _ClientScreenState();
}

class _ClientScreenState extends State<ClientScreen> {
  final TextEditingController sendMsgControlller = TextEditingController();

  // void _init() async {
  //   final TextEditingController IpController = TextEditingController();
  //   return showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         title: const Text("Enter IP"),
  //         content: Center(
  //           child: TextField(
  //             controller: IpController,
  //           ),
  //         ),
  //         actions: [
  //           ElevatedButton(
  //             onPressed: () {
  //               Navigator.pop(context, IpController.text);
  //             },
  //             child: const Text("Done"),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  @override
  void initState() {
    clientSocket();
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
        title: const Text("Client Socket"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: GetBuilder(
            init: SocketController(),
            builder: (SocketController controller) {
              if (controller.isClientConnected == false) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.blueAccent,
                  ),
                );
              }

              return Column(
                children: [
                  Text(
                    "Socket Connected to: ${controller.getClientSocket?.remoteAddress}:${controller.getClientSocket?.remotePort}",
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
                              .sendClientMsg(sendMsgControlller.text.trim());
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
