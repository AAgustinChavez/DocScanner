import 'package:auth_buttons/auth_buttons.dart';
import 'package:doc_scanner/createUser/create_account_page.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

class FormBody extends StatelessWidget {

  final ValueChanged<bool> onGoogleLoginTap;
  final _formKey = GlobalKey<FormState>();
  final _formKey1 = GlobalKey<FormState>();

  FormBody({
    Key? key,
    required this.onGoogleLoginTap,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // logo
        Column(
              children: [
                Container(
                  alignment: Alignment.topCenter,
                  
                  width: 210,
                  child: 
                    Image.asset('assets/ProjectLogo.PNG', ),
                ),
                const SizedBox(height: 5.0),
              ],
            ),
            const SizedBox(height: 20.0),

            TextFormField(
              autovalidateMode: AutovalidateMode.always,
              key: _formKey,
              keyboardType: TextInputType.visiblePassword,
              decoration: const InputDecoration(
                icon: Icon(Icons.email_outlined, color: Colors.black,),
                labelText: 'Email',
                labelStyle: TextStyle(
                    color: Colors.black,
                ),
              ),
              validator: (value){
                if(value == null || value.isEmpty){

                }
                return null;
              }, 
            ),
            const SizedBox(height: 12.0),

            TextFormField(
              autovalidateMode: AutovalidateMode.always,
              key: _formKey1,
              keyboardType: TextInputType.visiblePassword,
              decoration: const InputDecoration(
                icon: Icon(Icons.lock, color: Colors.black,),
                labelText: 'Password',
                labelStyle: TextStyle(
                    color: Colors.black,
                    
                ),
                
              ),
              obscureText: true,
              validator: (value){
                if(value == null || value.isEmpty){

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
                    child: MaterialButton(
                      
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0,),
                        side: const BorderSide(color: Colors.black),
                      ),
                      onPressed: () => {},
                      color: Colors.white,
                    
                      child: Row(
                        children: const [
                          
                          SizedBox(width: 14),
                          Expanded(
                            child: Text(
                              "Login",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6.0),
            const Text("or", textAlign: TextAlign.center, style: TextStyle(color: Colors.black54),),
            const SizedBox(height: 6.0),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 32),
              child: Row(
                children: [
                  Expanded(
                    child: GoogleAuthButton(
                      onPressed: () => onGoogleLoginTap(true),
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
                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => CreateAccountPage()));
                  },
                  child: const Text("Create an account",textAlign: TextAlign.center, style: TextStyle(color: Colors.lightGreen),),
                ),
              ]
            ),
      ],
    );
  }
}