import 'package:bloc/bloc.dart';
import 'package:doc_scanner/auth/user_auth_repository.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserAuthRepository _userRep = UserAuthRepository();

  LoginBloc() : super(LoginInitial()) {
    on<LoginWithGoogleEvent>(_googleLogin);
  }

  Future _googleLogin(
    LoginEvent event,
    Emitter emitState,
  ) async {
    try {
      await _userRep.signInWithGoogle();
      emitState(LoginSuccessState());
    } catch (e) {
      emitState(
        LoginErrorState(
          error: "Error al hacer login con google",
          code: e.toString(),
        ),
      );
    }
  }
}
