import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());

  Future<void> registerUser(
      {required String email, required String password}) async {
    emit(SignupLoading());
    try {
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      emit(SignupSuccess());
    } on FirebaseAuthException catch (ex) {
      if (ex.code == 'weak-password') {
        emit(SignupFailure('Weak password'));
      } else if (ex.code == 'email-already-in-use') {
        emit(SignupFailure('Email already exists'));
      } else {
        emit(SignupFailure(ex.toString()));
      }
    } on Exception catch (e) {
      emit(SignupFailure(e.toString()));
    }
  }
}
