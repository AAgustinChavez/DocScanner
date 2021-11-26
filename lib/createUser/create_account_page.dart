import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:doc_scanner/createUser/bloc/create_bloc.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({Key? key}) : super(key: key);

  @override
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final _formKey = GlobalKey<FormState>();
  late CreateBloc _createBloc;
  String email = "", password = "";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: AppBar(
          backgroundColor: Colors.cyan,
          title: const Center(child: Text("Create Account", textAlign: TextAlign.center)),
        ),
      ),
      body: BlocProvider(
        create: (context) {
          _createBloc = CreateBloc();
          return _createBloc;
        },
        child: BlocListener<CreateBloc, CreateState>(
          listener: (context, state) {
            if (state is CreateSuccessState) Navigator.of(context).pop();
 
          },
          child: Form(
            autovalidateMode: AutovalidateMode.always,
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(30),
              children: [
                const SizedBox(
                  height: 25,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    label: Text("  Email"),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    } else {
                      email = value;
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 45,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text("  Password"),
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    } else if (value.length < 8) {
                      return '';
                    } else {
                      password = value;
                    }
                    return null;
                  },
                ),
                const Text(
                  "  Must be at least 8 characters",
                  style: TextStyle(color: Colors.black54),
                ),
                const SizedBox(
                  height: 35,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text(
                      "  Confirm Password",
                    ),
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    } else if (password != value) {
                      return 'Passwords must match';
                    }
                    return null;
                  },
                ),
                const Text(
                  "  Both passwords must match",
                  style: TextStyle(color: Colors.black54),
                ),
                const SizedBox(
                  height: 35,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.cyan),
                      elevation: MaterialStateProperty.all(5.0),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        side: const BorderSide(width: 1.0, color: Colors.black),
                      ))),
                  onPressed: () {
                    // Validate returns true if the form is valid, or false otherwise.
                    if (_formKey.currentState!.validate()) {
                      _createBloc.add(CreateUserEvent(

                        email: email, password: password,
                      ));

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                    }
                  },
                  child: const Text('Sign up',
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                ),
                const SizedBox(
                  height: 15,
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: "Already have an account? ",
                    style: const TextStyle(color: Colors.black),
                    children: <TextSpan>[
                      TextSpan(
                        text: "Login",
                        style: const TextStyle(color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context).pop();
                          },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}