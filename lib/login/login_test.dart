import 'dart:io';

import 'package:auth_buttons/auth_buttons.dart';
import 'package:doc_scanner/createUser/create_account_page.dart';
import 'package:doc_scanner/create_file_img.dart';
import 'package:doc_scanner/login/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:doc_scanner/createUser/bloc/create_bloc.dart';

class LoginTest extends StatefulWidget {
  const LoginTest({Key? key}) : super(key: key);

  @override
  _LoginTestState createState() => _LoginTestState();
}

class _LoginTestState extends State<LoginTest> {
  
  final _formKey = GlobalKey<FormState>();
  late LoginBloc _loginBloc;
  String email = "", password = "";

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
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.cyan,
          title: Center(child: Text("Login", textAlign: TextAlign.center)),
      ),
      body: SafeArea(
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
                    margin: const EdgeInsets.symmetric(vertical: 50, horizontal: 24),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          color: Color(0xa0FFffff),
                    ),
                    child: Form(
                      autovalidateMode: AutovalidateMode.always,
                      key: _formKey,
                      child: Column(
                        children: [
                          Column(
                            children: [
                              Container(
                                alignment: Alignment.topCenter,
                                width: 210,
                                child: Image.asset(
                                  'assets/ProjectLogo.PNG',
                                ),
                              ),
                              const SizedBox(height: 5.0),
                            ],
                          ),
                          const SizedBox(height: 20.0),
                          TextFormField(
                            decoration: const InputDecoration(
                              icon: Icon(
                                Icons.email_outlined,
                                color: Colors.black,
                              ),
                              labelText: 'Email',
                              labelStyle: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email.';
                              }else{
                                email = value;
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 12.0),
                          TextFormField(
                            decoration: const InputDecoration(
                              icon: Icon(
                                Icons.lock,
                                color: Colors.black,
                              ),
                              labelText: 'Password',
                              labelStyle: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password.';
                              }else{
                                password = value;
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 30.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Container(
                                  height: 40,
                                  margin: const EdgeInsets.symmetric(horizontal: 32),
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all(Colors.white),
                                        elevation: MaterialStateProperty.all(5.0),
                                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(18.0),
                                          side: const BorderSide(width: 1.0, color: Colors.black),
                                        ))),
                                    onPressed: () {
                                      // Validate returns true if the form is valid, or false otherwise.
                                      if (_formKey.currentState!.validate()) {
                                        _loginBloc.add(LoginWithFirebaseEvent(

                                          email: email, password: password,
                                        ));
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text('Processing Data')),
                                        );
                                      }
                                    },
                                    child: const Text('Login',
                                        style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500,
                                        )
                                    ),
                                  ),
                                  
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6.0),
                          const Text(
                            "or",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.black54),
                          ),
                          const SizedBox(height: 6.0),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 32),
                            child: Row(
                              children: [
                                Expanded(
                                  child: GoogleAuthButton(
                                    onPressed: () => _googleLogIn(true),
                                    text: "Sign in with Google",
                                    style: const AuthButtonStyle(borderRadius: 18),
                                    darkMode: false,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) => const CreateAccountPage()));
                                  },
                                  child: const Text(
                                    "Create an account",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.lightGreen),
                                  ),
                                ),
                              ]),
                        ],
                      ),
                    ),
                  )
                )
                );
              }
          ),
        ),
      ),
    );
  }
}