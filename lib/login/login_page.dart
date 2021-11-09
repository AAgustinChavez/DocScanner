import 'package:doc_scanner/auth/google_sign_in.dart';

import 'package:doc_scanner/login/create_account.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'dart:ui';

import '../create_file_img.dart';

class LoginPage extends StatefulWidget {

  const LoginPage({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _unfocusedColor = Colors.grey[600];
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();


  @override
  void initState() {
    super.initState();
    _emailFocusNode.addListener(() {
      setState(() {
        
      });
    });

    _passwordFocusNode.addListener(() {
      setState(() {
        
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: AppBar(
          backgroundColor: Colors.cyan,
          title: const Center(child: Text("Login", textAlign: TextAlign.center)),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          children: [
            const SizedBox(height: 30.0),
            Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 110,
                  width: 210,
                  child: 
                    Image.asset('assets/ProjectLogo.PNG', fit: BoxFit.fill,),
                ),
                const SizedBox(height: 5.0),
              ],
            ),
            const SizedBox(height: 20.0),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                icon: const Icon(Icons.email_outlined, color: Colors.black,),
                labelText: 'Email',
                labelStyle: TextStyle(
                    color: _emailFocusNode.hasFocus
                        ? Theme.of(context).colorScheme.secondary
                        : _unfocusedColor),
              ),
              focusNode: _emailFocusNode,
            ),
            const SizedBox(height: 12.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                icon: const Icon(Icons.lock, color: Colors.black,),
                labelText: 'Password',
                labelStyle: TextStyle(
                    color: _passwordFocusNode.hasFocus
                        ? Theme.of(context).colorScheme.secondary
                        : _unfocusedColor),
              ),
              focusNode: _passwordFocusNode,
              obscureText: true,
            ),
            const SizedBox(
              height: 50.0,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 32),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        //Navigator.pop(context);
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => CreateFileIMG()));
                      },
                      child: const Text('Login', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 17),),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                        elevation: MaterialStateProperty.all(3.0),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            side: const BorderSide(width: 1.0, color: Colors.black),
                          )
                        )
                      ),
                    )
                  ),
                ],
              ),
            ),
           
            const Text("or", textAlign: TextAlign.center, style: TextStyle(color: Colors.black54),),

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 32),
              child: Row(
                children: [
                  
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        onPrimary: Colors.black,
                        minimumSize: const Size(double.infinity, 50),
                      ), 
                      icon: FaIcon(FontAwesomeIcons.google, color: Colors.blue,),
                      label: Text('Sign Up with Google'),
                      onPressed: () {
                        context.read<GoogleSignInProvider>().googleLogin(); 
                      },
                      /*Consumer<GoogleSignInProvider>(
                      builder: (context, googleLogin, child){
                        return ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            onPrimary: Colors.black,
                            minimumSize: const Size(double.infinity, 50),
                          ), 
                          icon: FaIcon(FontAwesomeIcons.google, color: Colors.blue,),
                          label: Text('Sign Up with Google'),
                          onPressed: () {
                            context.read<GoogleSignInProvider>().googleLogin(); 
                          },
                        );
                      },
                      /*child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          onPrimary: Colors.black,
                          minimumSize: const Size(double.infinity, 50),
                        ), 
                        icon: FaIcon(FontAwesomeIcons.google, color: Colors.blue,),
                        label: Text('Sign Up with Google'),
                        onPressed: () {
                          context.read<GoogleSignInProvider>().googleLogin(); 
                        },
                      ),*/
                      */
                    )
                  ),
                ],
              ),
            ),
            
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => CreateAccount()));
                  },
                  child: const Text("Create an account",textAlign: TextAlign.center, style: TextStyle(color: Colors.lightGreen),),
                ),
              ]
            ),
          ],
        ),
      ),
    );
  }
}

Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}