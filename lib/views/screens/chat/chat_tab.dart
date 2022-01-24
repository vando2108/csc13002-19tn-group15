import 'dart:async';
import 'dart:convert';

import 'package:flashare/models/api.dart';
import 'package:flashare/providers/fetch_list_contact.dart';
import 'package:flashare/utils/user_storage.dart';
import 'package:flashare/views/screens/chat/char_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatTab extends StatefulWidget {
  const ChatTab({Key? key}) : super(key: key);
  @override
  _ChatTabState createState() => _ChatTabState();
}

class _ChatTabState extends State<ChatTab> {
  Timer? timer;
  late Future<ApiResponse> list_contact_;

  @override
  void initState() {
    // TODO: implement initState
    list_contact_ = FetchListContact();
    timer = Timer.periodic(Duration(seconds: 10), (timer) {
      if (mounted) {
        setState(() {
          list_contact_ = FetchListContact();
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Center(child: Text("Contacts")),
        ),
        body: FutureBuilder(
          future: list_contact_,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              ApiResponse temp = snapshot.data as ApiResponse;
              if (temp.Sucess == false) {
                return const Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                itemCount: temp.Data.length,
                itemBuilder: (context, index) {
                  var contact = Contact();
                  contact.fromMap(temp.Data[index]);
                  return GestureDetector(
                    onTap: () => {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ChatScreen(
                          receiver: contact.Reciver,
                        );
                      }))
                    },
                    child: SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20 * 0.75),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 24,
                              backgroundImage: NetworkImage((contact.Avatar == "")
                                  ? "https://scontent.fvca1-1.fna.fbcdn.net/v/t1.6435-9/71286345_2193084204317518_881016848903045120_n.jpg?_nc_cat=102&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=AnsPLtSQyfcAX9AsRQ1&_nc_ht=scontent.fvca1-1.fna&oh=00_AT8EtCl_nR-1L3TZN6ziJYiG__ZEPFivDp7CpMp8t1ZjkQ&oe=62048DCF"
                                  : contact.Avatar),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      contact.Name,
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(height: 8),
                                    Opacity(
                                      opacity: 0.64,
                                      child: Text(
                                        contact.LastMessage,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(fontSize: 13),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Text(contact.Time),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ));
  }
}
