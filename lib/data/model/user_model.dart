// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class User {
  String id;
  String name;
  Color color;
  Message? lastMessage;

  User({
    required this.id,
    required this.name,
    required this.color,
    this.lastMessage,
  });
}

class Message {
  String id;
  String text;
  DateTime timestamp;
  User sender;

  Message(
      {required this.id,
      required this.text,
      required this.timestamp,
      required this.sender});
}
