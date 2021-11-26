import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'create_event.dart';
part 'create_state.dart';

class CreateBloc extends Bloc<CreateEvent, CreateState> {

  CreateBloc() : super(CreateInitial()) {
    on<CreateUserEvent>((event, emit) async {
      emit(LoadingState());
      //bool saved = await _createAccount(event.user);
      bool saved = await _createAccount(event.email, event.password);
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
    //Map<String, dynamic> user,
    String email,
    String password,
  ) async {
    //CollectionReference _users = FirebaseFirestore.instance.collection('Users');
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password
      );
      //await _users.add(user);
      return true;
    } on FirebaseAuthException catch (e) {
      if(e.code == 'email-already-in-use'){
        print('The account already exists for that email.');
      }
      return false;
    }catch (e){
      return false;
    }
  }
}