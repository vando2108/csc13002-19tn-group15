import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

import 'package:flashare/models/api.dart';
import 'package:flashare/models/message.dart';
import 'package:flashare/providers/message_api.dart';
import 'package:flashare/utils/user_storage.dart';
import 'package:flashare/views/screens/chat/chat_tab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    Key? key,
    required this.receiver,
    required this.receiver_name,
  }) : super(key: key);

  final String receiver;
  final String receiver_name;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late var _channel;
  List<Message> _chat = [];
  ScrollController _scrollController = new ScrollController();
  late String userID = "";
  final content_controller = TextEditingController();
  late int count = 0;
  Timer? timer;

  Future<void> Init() async {
    final tempUserid = await SecureStorage.readSecureData(SecureStorage.userID);
    setState(() {
      userID = tempUserid;
    });
    _channel = WebSocketChannel.connect(Uri.parse("ws://" +
        dotenv.env["DOMAIN"].toString() +
        "/api/chat?sender=" +
        userID +
        "&receiver=" +
        widget.receiver));
    ApiResponse temp = await FetchListMessage(userID, widget.receiver);
    if (temp.Data == null) {
      setState(() {
        _chat.add(Message("", "", "", DateTime.now()));
      });
    } else {
      final list_msg = temp.Data.reversed.toList();
      for (var it in list_msg) {
        setState(() {
          _chat.add(Message.fromJson(it));
        });
      }
    }
    _channel.stream.listen((event) {
      var temp = jsonDecode(event);
      var msg = Message.fromJson(temp);
      setState(() {
        _chat.add(msg);
      });
      setState(() {
        count = 0;
      });
      timer = Timer.periodic(Duration(milliseconds: 500), (timer) {
        if (count == 2) timer.cancel();
        setState(() {
          count++;
        });
        scrollToEnd();
      });
    });
  }

  @override
  initState() {
    super.initState();
    Init();
    timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (mounted) {
        if (count == 2) timer.cancel();
        setState(() {
          count++;
        });
        scrollToEnd();
      }
    });
    scrollToEnd();
  }

  @override
  void dispose() {
    super.dispose();
    _channel.sink.close();
  }

  void scrollToEnd() async {
    await _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(microseconds: 200),
        curve: Curves.easeOut);
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
        title: Text(widget.receiver_name),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView.builder(
                  controller: _scrollController,
                  itemCount: _chat.length,
                  itemBuilder: (context, index) {
                    print(_chat[index]);
                    if (_chat[index].message == "") {
                      return Container();
                    }
                    return Center(
                      child: MessageRender(chat: _chat[index], userID: userID),
                    );
                  }),
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
                      child: TextField(
                        controller: content_controller,
                        decoration: const InputDecoration(
                            hintText: "Aa", border: InputBorder.none),
                      ),
                    ),
                  ),
                  const IconButton(
                    onPressed: null,
                    icon: Icon(Icons.image),
                  ),
                  IconButton(
                      onPressed: () async {
                        if (content_controller.text != "") {
                          final response = await SendMessage(
                              widget.receiver, content_controller.text);
                          if (response.Sucess == false) {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return CupertinoAlertDialog(
                                    title: const Text("Error"),
                                    content: Text(response.Data),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text("Close"),
                                      )
                                    ],
                                  );
                                });
                          }
                        }
                        content_controller.clear();
                        scrollToEnd();
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
