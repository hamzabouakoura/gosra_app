import 'package:flutter/material.dart';
import 'package:gosra_app/constants.dart';
import 'package:gosra_app/models/message_model.dart';

class ChatBubble extends StatelessWidget {
  ChatBubble({
    super.key,
    required this.message,
    required this.borderRadius,
    required this.alignment,
    required this.color,
  });
  Message message;
  BorderRadius borderRadius;
  Alignment alignment;
  Color color;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Container(
        margin: const EdgeInsets.only(left: 20, right: 10, top: 4, bottom: 4),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          color: color,
        ),
        child: Text(
          message.message!,
          style: TextStyle(
            color: Colors.black87,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
