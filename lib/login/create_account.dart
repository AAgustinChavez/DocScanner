import 'package:flutter/material.dart';

class CreateAccount extends StatefulWidget{
  const CreateAccount({Key? key}) : super(key: key);

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount>{

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: AppBar(
          backgroundColor: Colors.cyan,
          title: Text("Create an Account", textAlign: TextAlign.center),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(30),
          children: [
            SizedBox(height: 25,),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                label: Text("  Email"),
                border: OutlineInputBorder(),
              ),
              validator: (value){
                if(value == null || value.isEmpty){

                }
                return null;
              },
            ),
            SizedBox(height: 45,),
            TextFormField(
              decoration: InputDecoration(
                label: Text("  Password"),
                border: OutlineInputBorder(),
              ),
              validator: (value){
                if(value == null || value.isEmpty){

                }
                return null;
              },
            ),
            Text("  Must be at least 8 characters", style: TextStyle(color: Colors.black54),),
            SizedBox(height: 35,),
            TextFormField(
              //keyboardType: TextInputType.,
              decoration: InputDecoration(
                label: Text("  Confirm Password",),
                border: OutlineInputBorder(),
              ),
              validator: (value){
                if(value == null || value.isEmpty){

                }
                return null;
              }, 
            ),
            Text("  Both passwords must match", style: TextStyle(color: Colors.black54),),
            SizedBox(height: 35,),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.cyan),
                elevation: MaterialStateProperty.all(5.0),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            side: const BorderSide(width: 1.0, color: Colors.black),
                          )
                        )
              ),
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );
                }
              },
              child: const Text('Sign up', style: TextStyle(color: Colors.white, fontSize: 20)),
            ),
          ],
        ),
      ),
    );
  }
}