import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gosra_app/components/chat_bubble.dart';
import 'package:gosra_app/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gosra_app/helper/show_progress.dart';
import 'package:gosra_app/models/message_model.dart';
import 'package:gosra_app/screens/blocs/auth_bloc/auth_bloc.dart';
import 'package:gosra_app/screens/cubits/chat_cubit/chat_cubit.dart';
import 'package:gosra_app/screens/cubits/login_cubit/login_cubit.dart';

class ChatPage extends StatelessWidget {
  static String id = 'ChatPage';

  TextEditingController controller = TextEditingController();

  String? data;
  final _scrollController = ScrollController();
  bool? isSent;
  List<Message> messagesList = [];

  @override
  Widget build(BuildContext context) {
    var email = BlocProvider.of<AuthBloc>(context).email;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () async {
              BlocProvider.of<ChatCubit>(context).SignOut();
              Navigator.pop(context);
            },
            icon: Icon(Icons.logout),
          ),
        ],
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              kLogo,
              height: 60,
            ),
            const Text("Let's chat"),
          ],
        ),
        backgroundColor: kPrimaryColor,
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<ChatCubit, ChatState>(
              listener: (context, state) {
                if (state is ChatMessageSent) {
                  messagesList = state.messagesList;
                } else if (state is ChatMessageFailed) {}
              },
              builder: (context, state) {
                return ListView.builder(
                  reverse: true,
                  controller: _scrollController,
                  itemCount: messagesList.length,
                  itemBuilder: (context, index) {
                    if (messagesList[index].id == email) {
                      return Row(
                        children: [
                          ChatBubble(
                            message: messagesList[index],
                            borderRadius: sentMessageRadius,
                            alignment: sentMessageAlignement,
                            color: kSecondaryColor,
                          ),
                          Icon(
                            Icons.done_all_rounded,
                            size: 15,
                          ),
                        ],
                      );
                    } else {
                      return ChatBubble(
                        message: messagesList[index],
                        borderRadius: receivedMessageRadius,
                        alignment: receivedMessageAlignement,
                        color: kPrimaryColor,
                      );
                    }
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: controller,
              onChanged: (value) {
                data = value;
              },
              decoration: InputDecoration(
                hintText: 'Send Message',
                suffixIcon: IconButton(
                  onPressed: () {
                    BlocProvider.of<ChatCubit>(context)
                        .addMessage(data: data!, email: email!);
                    controller.clear();

                    _scrollController.animateTo(
                      0,
                      curve: Curves.easeOut,
                      duration: const Duration(milliseconds: 500),
                    );
                  },
                  icon: Icon(
                    Icons.send,
                    color: kSecondaryColor,
                  ),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: kPrimaryColor,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
