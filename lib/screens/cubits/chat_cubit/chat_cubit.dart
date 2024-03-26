import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gosra_app/constants.dart';
import 'package:gosra_app/models/message_model.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollection);

  addMessage({required String data, required String email}) async {
    try {
      await messages.add({
        kMessage: data,
        kcurrentDate: DateTime.now(),
        kId: email,
      });
    } on Exception catch (e) {
      emit(ChatMessageFailed());
    }
  }

  Future<void> SignOut() async {
    await FirebaseAuth.instance.signOut();
  }

  void getData() {
    messages
        .orderBy(kcurrentDate, descending: true)
        .snapshots()
        .listen((event) {
      List<Message> messagesList = [];
      for (int i = 0; i < event.docs.length; i++) {
        messagesList.add(
          Message.fromJson(event.docs[i]),
        );
        emit(ChatMessageSent(messagesList: messagesList));
      }
    });
  }
}
