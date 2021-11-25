import 'package:doc_scanner/create_file_img.dart';
import 'package:doc_scanner/login/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'form_body.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  // inicializar instacia de login bloc
  late LoginBloc _loginBloc;

  final bool _showLoading = false;

  @override
  void dispose() {
    _loginBloc.close();
    super.dispose();
  }

  void _googleLogIn(bool _) {
    // invocar al login de firebase con el bloc
    // recodar configurar pantallad Oauth en google Cloud
    print("google");
    // agregar evento al login bloc
    _loginBloc.add(LoginWithGoogleEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        
        SafeArea(
          child: BlocProvider(
            create: (context) {
              _loginBloc = LoginBloc();
              return _loginBloc;
            },
            child: BlocConsumer<LoginBloc, LoginState>(
              listener: (context, state) {
                if (state is LoginErrorState) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Error"),
                        content: Text("${state.error}:\n${state.code}"),
                      );
                    },
                  );
                }
              },
              builder: (context, state) {
                if (state is LoginSuccessState) {
                  return CreateFileIMG();
                }
                return SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxHeight: double.infinity,
                        maxWidth: double.infinity,
                      ),
                      child: Container(
                        
                        margin: const EdgeInsets.symmetric(vertical: 60, horizontal: 24),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          color: Color(0xa0FFffff),
                        ),
                        child: FormBody(
                          onGoogleLoginTap: _googleLogIn,
                        ),
                      ),
                    ),
                  );
                
              },
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: _showLoading ? const CircularProgressIndicator() : Container(),
        ),
      ],
    );
  }
}