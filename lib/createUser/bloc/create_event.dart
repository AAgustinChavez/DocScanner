part of 'create_bloc.dart';

abstract class CreateEvent extends Equatable {
  const CreateEvent();

  @override
  List<Object> get props => [];
}

class CreateUserEvent extends CreateEvent{
  //final Map<String, dynamic> user;
  final String email;
  final String password;
  //const CreateUserEvent({required this.user});
  const CreateUserEvent({required this.email, required this.password});

  @override
  //List<Object> get props => [user];
  List<Object> get props => [email, password];
}