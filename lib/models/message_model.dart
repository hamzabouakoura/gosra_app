import 'package:flutter/material.dart';
import 'package:gosra_app/constants.dart';

class Message {
  final String? message;
  final String? id;

  Message({this.message, this.id});

  factory Message.fromJson(jsonData) {
    return Message(
      message: jsonData['message'],
      id: jsonData['id'],
    );
  }
}
