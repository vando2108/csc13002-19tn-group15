import 'dart:convert';

import 'package:flashare/models/api.dart';
import 'package:flashare/models/message.dart';
import 'package:flashare/providers/message_api.dart';
import 'package:flashare/utils/user_storage.dart';
import 'package:flashare/views/screens/chat/chat_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    Key? key,
    required this.receiver,
  }) : super(key: key);

  final String receiver;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late var _channel;
  List<Message> _chat = [];
  ScrollController _scrollController = new ScrollController();
  late String userID = "";

  Future<void> Init() async {
    final temp_userid =
        await SecureStorage.readSecureData(SecureStorage.userID);
    setState(() {
      userID = temp_userid;
    });
    _channel = WebSocketChannel.connect(Uri.parse(
        "ws://" + dotenv.env["HOST"].toString() + "/api/chat?sender=" +
            userID +
            "&receiver=" +
            widget.receiver));
    ApiResponse temp = await FetchListMessage(userID, widget.receiver);
    for (var it in temp.Data) {
      setState(() {
        _chat.add(Message.fromJson(it));
      });
    }
    _channel.stream.listen((event) {
      var temp = jsonDecode(event);
      var msg = Message.fromJson(temp);
      setState(() {
        _chat.add(msg);
      });
    });
  }

  @override
  initState() {
    super.initState();
    Init();
  }

  @override
  void dispose() {
    super.dispose();
    _channel.sink.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text("Kdimo"),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView.builder(
                controller: _scrollController,
                itemCount: _chat.length,
                itemBuilder: (context, index) => Center(
                  child: MessageRender(chat: _chat[index], userID: userID),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20 * 0.75,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: const TextField(
                        decoration: InputDecoration(
                            hintText: "Aa", border: InputBorder.none),
                      ),
                    ),
                  ),
                  const IconButton(
                    onPressed: null,
                    icon: Icon(Icons.image),
                  ),
                  IconButton(
                      onPressed: () {
                        _scrollController.animateTo(
                            _scrollController.position.maxScrollExtent,
                            duration: const Duration(microseconds: 200),
                            curve: Curves.easeOut);
                      },
                      icon: const Icon(
                        Icons.send,
                        color: Colors.blue,
                      ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class MessageRender extends StatelessWidget {
  const MessageRender({
    Key? key,
    required chat,
    required this.userID,
  })  : _chat = chat,
        super(key: key);

  final Message _chat;
  final String userID;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: _chat.senderid != userID
          ? MainAxisAlignment.start
          : MainAxisAlignment.end,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 20),
          padding: const EdgeInsets.symmetric(
            horizontal: 20 * 0.75,
            vertical: 10,
          ),
          width: 200,
          decoration: BoxDecoration(
              color: _chat.senderid != userID
                  ? const Color(0xffEFEEEE)
                  : Colors.blue,
              borderRadius: BorderRadius.circular(30)),
          child: Text(
            _chat.message,
            style: TextStyle(
              color: _chat.senderid != userID ? Colors.black : Colors.white,
            ),
          ),
        )
      ],
    );
  }
}