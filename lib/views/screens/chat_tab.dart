import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:web_socket_channel/web_socket_channel.dart';

class Message {
  final String message;
  final String senderid;
  final String reciverid;

  Message(this.message, this.senderid, this.reciverid);

  Message.fromJson(Map<String, dynamic> json)
      : message = json['message'],
        senderid = json['senderid'],
        reciverid = json['reciverid'];
}

class ChatTab extends StatefulWidget {
  const ChatTab({Key? key}) : super(key: key);
  @override
  _ChatTabState createState() => _ChatTabState();
}

class _ChatTabState extends State<ChatTab> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () =>
            Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const ChatScreen();
        })),
        child: Text("Chat"),
      ),
    );
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _channel =
      WebSocketChannel.connect(Uri.parse("ws://192.168.1.8:8080/api/chat"));

  List<Message> _chat = [];
  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();

    _channel.stream.listen((event) {
      var temp = jsonDecode(event);
      var msg = Message.fromJson(temp);
      setState(() {
        _chat.add(msg);
      });
    });
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
                  child: MessageRender(chat: _chat[index]),
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
                          hintText: "Aa",
                          border: InputBorder.none
                        ),
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
                      icon: const Icon(Icons.send, color: Colors.blue,))
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
  })  : _chat = chat,
        super(key: key);

  final Message _chat;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: _chat.senderid == "Ha Minh"
          ? MainAxisAlignment.start
          : MainAxisAlignment.end,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 20),
          padding: const EdgeInsets.symmetric(
            horizontal: 20 * 0.75,
            vertical: 10,
          ),
          decoration: BoxDecoration(
              color: _chat.senderid == "Ha Minh"
                  ? const Color(0xffEFEEEE)
                  : Colors.blue,
              borderRadius: BorderRadius.circular(30)),
          child: Text(
            _chat.message,
            style: TextStyle(
              color: _chat.senderid == "Ha Minh" ? Colors.black : Colors.white,
            ),
          ),
        )
      ],
    );
  }
}
