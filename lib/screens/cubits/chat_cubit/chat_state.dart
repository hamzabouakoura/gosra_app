part of 'chat_cubit.dart';

@immutable
abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatMessageSent extends ChatState {
  List<Message> messagesList;
  ChatMessageSent({required this.messagesList});
}

class ChatMessageFailed extends ChatState {}

class ChatGetData extends ChatState {}

class ChatSignOut extends ChatState {}
