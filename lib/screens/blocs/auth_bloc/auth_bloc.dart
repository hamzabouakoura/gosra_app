import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  String? email;
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is LoginEvent) {
        emit(BlocLoginLoading());
        try {
          UserCredential user = await FirebaseAuth.instance
              .signInWithEmailAndPassword(
                  email: event.email, password: event.password);
          emit(BlocLoginSuccess());
        } on FirebaseAuthException catch (ex) {
          if (ex.code == 'user-not-found') {
            emit(BlocLoginFailure("Account doesn't exists"));
          } else if (ex.code == 'wrong-password') {
            emit(BlocLoginFailure('Incorrect Password'));
          } else {
            emit(BlocLoginFailure(ex.toString()));
          }
        } on Exception catch (e) {
          emit(BlocLoginFailure(e.toString()));
        }
      } else if (event is SignupEvent) {
        emit(BlocSignupLoading());
        try {
          UserCredential user = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: event.email, password: event.password);
          emit(BlocSignupSuccess());
        } on FirebaseAuthException catch (ex) {
          if (ex.code == 'weak-password') {
            emit(BlocSignupFailure('Weak password'));
          } else if (ex.code == 'email-already-in-use') {
            emit(BlocSignupFailure('Email already exists'));
          } else {
            emit(BlocSignupFailure(ex.toString()));
          }
        } on Exception catch (e) {
          emit(BlocSignupFailure(e.toString()));
        }
      }
    });
  }
}
