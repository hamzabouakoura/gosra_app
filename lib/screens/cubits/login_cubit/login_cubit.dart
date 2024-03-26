import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  String? email;

  Future<void> loginUser(
      {required String email, required String password}) async {
    emit(LoginLoading());
    try {
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      emit(LoginSuccess());
    } on FirebaseAuthException catch (ex) {
      if (ex.code == 'user-not-found') {
        emit(LoginFailure("Account doesn't exists"));
      } else if (ex.code == 'wrong-password') {
        emit(LoginFailure('Incorrect Password'));
      } else {
        emit(LoginFailure(ex.toString()));
      }
    } on Exception catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }
}
