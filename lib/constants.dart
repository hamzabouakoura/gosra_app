import 'package:flutter/material.dart';

final Color kPrimaryColor = Colors.lightBlue.shade100;
final Color kSecondaryColor = Colors.lightBlue.shade300;
const kLogo = 'images/Online_messaging.png';
const kAppName = 'Gosra';
const kMessagesCollection = 'messages';
const kMessage = 'message';
const kcurrentDate = 'currentDate';
const kId = 'id';
const MessageSentIcon = Icon(
  Icons.done_all_rounded,
  size: 15,
);
const MessageFailedIcon = Icon(Icons.error);

const sentMessageRadius = BorderRadius.only(
    topLeft: Radius.circular(30),
    topRight: Radius.circular(30),
    bottomRight: Radius.circular(30));
const receivedMessageRadius = BorderRadius.only(
    topLeft: Radius.circular(30),
    topRight: Radius.circular(30),
    bottomLeft: Radius.circular(30));
const sentMessageAlignement = Alignment.centerLeft;
const receivedMessageAlignement = Alignment.centerRight;
