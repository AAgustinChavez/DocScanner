import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'create_event.dart';
part 'create_state.dart';

class CreateBloc extends Bloc<CreateEvent, CreateState> {

  CreateBloc() : super(CreateInitial()) {
    on<CreateUserEvent>((event, emit) async {
      emit(LoadingState());
      bool saved = await _createAccount(event.user);
      emit(
        saved ? 
        CreateSuccessState() : 
        const CreateErrorState(
          error: 'No se pudo crear la cuenta.'
        ) 
      );
    });
  }

  Future<bool> _createAccount(
    Map<String, dynamic> user,
  ) async {
    CollectionReference _users = FirebaseFirestore.instance.collection('Users');
    try {
      await _users.add(user);
      return true;
    } catch (e) {
      return false;
    }
  }
}