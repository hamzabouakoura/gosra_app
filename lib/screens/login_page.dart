import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gosra_app/components/custom_button.dart';
import 'package:gosra_app/components/custom_textfield.dart';
import 'package:gosra_app/constants.dart';
import 'package:gosra_app/helper/show_progress.dart';
import 'package:gosra_app/helper/snack_bar.dart';
import 'package:gosra_app/screens/blocs/auth_bloc/auth_bloc.dart';
import 'package:gosra_app/screens/chat_page.dart';
import 'package:gosra_app/screens/signup_page.dart';

import 'cubits/chat_cubit/chat_cubit.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  static String id = 'LoginPage';
  String? email;
  String? password;
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController controller = TextEditingController();
  TextEditingController controller2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is BlocLoginLoading) {
          showProgress(context);
        } else if (state is BlocLoginSuccess) {
          Navigator.pop(context);
          BlocProvider.of<ChatCubit>(context).getData();
          Navigator.pushNamed(context, ChatPage.id);
          BlocProvider.of<AuthBloc>(context).email = email;

          controller.clear();
          controller2.clear();
        } else if (state is BlocLoginFailure) {
          showSnackBar(context, state.error);
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                SizedBox(
                  height: size.height * 0.04,
                ),
                SizedBox(
                  height: size.height * 0.18,
                  child: Image.asset(kLogo),
                ),
                const Center(
                  child: Text(
                    kAppName,
                    style: TextStyle(
                      fontSize: 40,
                      fontFamily: 'pacifico',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: const [
                    Text(
                      'Login',
                      style:
                          TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                  controller: controller,
                  onChanged: (value) {
                    email = value;
                  },
                  hint: 'Email',
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                  obscureText: true,
                  controller: controller2,
                  onChanged: (value) {
                    password = value;
                  },
                  hint: 'Password',
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomButton(
                  ontap: () async {
                    if (formKey.currentState == null) {
                      print("formKey.currentState is null!");
                    } else if (formKey.currentState!.validate()) {
                      BlocProvider.of<AuthBloc>(context).add(
                        LoginEvent(email: email!, password: password!),
                      );
                    }
                  },
                  text: 'Login',
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account ?"),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, SignUpPage.id);
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          color: kSecondaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
