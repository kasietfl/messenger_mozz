import 'package:flutter/material.dart';

class User {
  String id;
  String name;
  Color color;

  User({required this.id, required this.name, required this.color});
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
