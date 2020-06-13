import 'package:flutter/material.dart';
import 'package:Henfam/chat.dart';
import 'package:Henfam/chatModel.dart';

class ChatList extends StatefulWidget {
  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  List<ChatModel> list = ChatModel.list;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat"),
        backgroundColor: Colors.amber,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/chat',
                      arguments: Data(name: list[index].contact.name),
                    );
                  },
                  leading: Container(
                    width: 50,
                    height: 50,
                    child: CircleAvatar(
                      child: Text(list[index].contact.name[0]),
                      backgroundColor: Colors.amberAccent,
                      foregroundColor: Colors.white,
                    ),
                  ),
                  title: Text(list[index].contact.name),
                  subtitle: Wrap(direction: Axis.vertical, children: [
                    Text(list[index].lastMsg),
                    SizedBox(width: 25),
                    Text(list[index].lastMsgTime + " ago")
                  ]),
                  isThreeLine: true,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
