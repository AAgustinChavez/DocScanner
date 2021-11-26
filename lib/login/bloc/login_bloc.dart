import 'package:bloc/bloc.dart';
import 'package:doc_scanner/auth/user_auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserAuthRepository _userRep = UserAuthRepository();

  LoginBloc() : super(LoginInitial()) {
    on<LoginWithGoogleEvent>(_googleLogin);
    on<LoginWithFirebaseEvent>((event, emit) async {
      bool saved = await _firebaseLogin(event.email, event.password);
      emit(
        saved ? 
        LoginSuccessState() : 
        LoginErrorState(
          error: 'Error al intentar hacer login.', code: ''
        ) 
      );
    });
  }

  Future _googleLogin(
    LoginEvent event,
    Emitter emitState,
  ) async {
    try {
      await _userRep.signInWithGoogle();
      emitState(LoginSuccessState());
      //Navigator.of(context).push(MaterialPageRoute(builder: builder))
    } catch (e) {
      emitState(
        LoginErrorState(
          error: "Error al hacer login con google",
          code: e.toString(),
        ),
      );
    }
  }

  Future _firebaseLogin(
    String email,
    String password,
  ) async { 
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
      );
      return true;
    } on FirebaseAuthException catch (e) {
      if(e.code == 'user-not-found'){
        print('No user found for that email.');
      }else if(e.code == 'wrong-password'){
        print('Wrong password provided for that user.');
      }
      return false;
    }
  }
}
