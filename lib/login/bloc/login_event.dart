part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginWithGoogleEvent extends LoginEvent {}

class LoginWithAnonymousEvent extends LoginEvent {}

class LoginWithFacebookEvent extends LoginEvent {}