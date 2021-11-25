part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginSuccessState extends LoginState {}

class LoginErrorState extends LoginState {
  final String error;
  final String code;

  LoginErrorState({
    required this.error,
    required this.code,
  });

  @override
  List<Object> get props => [error, code];
}