import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gosra_app/components/custom_button.dart';
import 'package:gosra_app/components/custom_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gosra_app/constants.dart';
import 'package:gosra_app/helper/show_progress.dart';
import 'package:gosra_app/helper/snack_bar.dart';
import 'package:gosra_app/screens/cubits/signup_cubit/signup_cubit.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  static String id = 'SignUpPage';
  String? email;
  String? password;
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocListener<SignupCubit, SignupState>(
      listener: (context, state) {
        if (state is SignupLoading) {
          showProgress(context);
        } else if (state is SignupSuccess) {
          Navigator.pop(context);
          Navigator.pop(context);
        } else if (state is SignupFailure) {
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
                      'Sign Up',
                      style:
                          TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
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
                  onChanged: (value) {
                    password = value;
                  },
                  hint: 'Password',
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomButton(
                  text: 'Sign Up',
                  ontap: () async {
                    if (formKey.currentState == null) {
                      print("formKey.currentState is null!");
                    } else if (formKey.currentState!.validate()) {
                      BlocProvider.of<SignupCubit>(context)
                          .registerUser(email: email!, password: password!);
                    }
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account ?"),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Login',
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
