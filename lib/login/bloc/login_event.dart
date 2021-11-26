part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginWithGoogleEvent extends LoginEvent {}

class LoginWithFirebaseEvent extends LoginEvent {
  final String email;
  final String password;

  const LoginWithFirebaseEvent({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}