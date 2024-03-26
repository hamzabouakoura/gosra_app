import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gosra_app/screens/blocs/auth_bloc/auth_bloc.dart';
import 'package:gosra_app/screens/chat_page.dart';
import 'package:gosra_app/screens/cubits/chat_cubit/chat_cubit.dart';
import 'package:gosra_app/screens/cubits/login_cubit/login_cubit.dart';
import 'package:gosra_app/screens/cubits/signup_cubit/signup_cubit.dart';
import 'package:gosra_app/screens/login_page.dart';
import 'package:gosra_app/screens/signup_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gosra_app/simple_bloc_observer.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  BlocOverrides.runZoned(
    () => runApp(ChatApp()),
    blocObserver: SimpleBlocObserver(),
  );
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc()),
        BlocProvider(create: (context) => SignupCubit()),
        BlocProvider(create: (context) => ChatCubit()),
      ],
      child: MaterialApp(
        routes: {
          LoginPage.id: (context) => LoginPage(),
          SignUpPage.id: (context) => SignUpPage(),
          ChatPage.id: (context) => ChatPage(),
        },
        initialRoute: LoginPage.id,
      ),
    );
  }
}
