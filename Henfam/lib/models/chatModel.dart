import 'package:Henfam/models/contactModel.dart';

class ChatModel {
  final String lastMsg;
  final String lastMsgTime;
  final ContactModel contact;

  ChatModel({this.lastMsg, this.lastMsgTime, this.contact});

  static List<ChatModel> list = [
    ChatModel(
      lastMsg: "I'm close to Olin. Come outside!",
      lastMsgTime: "2m",
      contact: ContactModel(name: "Ramon Placensia"),
    ),
    ChatModel(
      lastMsg: "Got your food!",
      lastMsgTime: "5m",
      contact: ContactModel(name: "Justin Pang"),
    ),
    ChatModel(
      lastMsg: "Right here",
      lastMsgTime: "10m",
      contact: ContactModel(name: "Eric Han"),
    ),
    ChatModel(
      lastMsg: "Order is taking a while",
      lastMsgTime: "1d",
      contact: ContactModel(name: "Isaac McDonald"),
    ),
    ChatModel(
      lastMsg: "Placing food on counter now",
      lastMsgTime: "2d",
      contact: ContactModel(name: "Jennifer Smith"),
    ),
    ChatModel(
      lastMsg: "I'm close to Olin. Come outside",
      lastMsgTime: "3d",
      contact: ContactModel(name: "Ishan Pathirana"),
    ),
    ChatModel(
      lastMsg: "I'm close to Mann. Come outside!",
      lastMsgTime: "4d",
      contact: ContactModel(name: "Brandon Ingram"),
    ),
  ];
}
