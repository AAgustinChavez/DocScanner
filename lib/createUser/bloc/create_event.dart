part of 'create_bloc.dart';

abstract class CreateEvent extends Equatable {
  const CreateEvent();

  @override
  List<Object> get props => [];
}

class CreateUserEvent extends CreateEvent{
  final Map<String, dynamic> user;

  const CreateUserEvent({required this.user});

  @override
  List<Object> get props => [user];
}