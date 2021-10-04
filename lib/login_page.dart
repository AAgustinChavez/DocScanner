import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
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
        preferredSize: Size.fromHeight(40),
        child: AppBar(
          backgroundColor: Colors.cyan,
          title: Center(child: Text("Login", textAlign: TextAlign.center)),
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
                icon: Icon(Icons.email_outlined, color: Colors.black,),
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
                icon: Icon(Icons.lock, color: Colors.black,),
                labelText: 'Password',
                labelStyle: TextStyle(
                    color: _passwordFocusNode.hasFocus
                        ? Theme.of(context).colorScheme.secondary
                        : _unfocusedColor),
              ),
              focusNode: _passwordFocusNode,
              obscureText: true,
            ),
            SizedBox(
              height: 10.0,
            ),
            ButtonBar(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100.0, vertical: 5.0),
                  child: SizedBox(
                    width: 100,
                    height: 30,
                    child: ElevatedButton(
                      child: const Text('Login', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                        elevation: MaterialStateProperty.all(8.0),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(width: 1.0, color: Colors.black),
                          )
                        ),
                      ),
                      onPressed: () {
                        //Navigator.pop(context);
                      },
                    ),
                  ),
                ),
              ],
            ),
            Text("or sign in\nwith", textAlign: TextAlign.center, style: TextStyle(color: Colors.black54),),

            ButtonBar(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100.0, vertical: 5.0),
                  child: SizedBox(
                    width: 100,
                    height: 30,
                    child: ElevatedButton(
                      child: Image.asset("assets/SignInGoogle.PNG"),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                        elevation: MaterialStateProperty.all(8.0),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(width: 1.0, color: Colors.black),
                          )
                        ),
                      ),
                      onPressed: () {
                        //Navigator.pop(context);
                      },
                    ),
                  ),
                ),
              ],
            ),

            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: (){},
                  child: Text("Create an account",textAlign: TextAlign.center, style: TextStyle(color: Colors.lightGreen),),
                ),
              ]
            ),
          ],
        ),
      ),
    );
  }
}
