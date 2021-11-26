import 'dart:async';
import 'dart:math';

import 'package:doc_scanner/api/firebase_api.dart';
import 'package:doc_scanner/auth/bloc/auth_bloc.dart';
import 'package:doc_scanner/imagesFiles/imagefilter.dart';
import 'package:doc_scanner/login/login_test.dart';
import 'package:doc_scanner/model/firebase_file.dart';
import 'package:doc_scanner/page/image_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'dart:io';
import 'package:photofilters/photofilters.dart';
import 'package:image/image.dart' as imageLib;
import 'package:path/path.dart' as Path;

class CreateFileIMG extends StatefulWidget {
  const CreateFileIMG({Key? key}) : super(key: key); //const

  @override
  _CreateFileIMGState createState() => _CreateFileIMGState();
}

class _CreateFileIMGState extends State<CreateFileIMG> {
  late AuthBloc _authBloc;
  final FirebaseAuth auth = FirebaseAuth.instance;
  late Future<List<FirebaseFile>> futureFiles;

  @override
  void initState() {
    super.initState();
    final User? user = auth.currentUser;
    final uid = user!.uid;
    futureFiles = FirebaseApi.listAll('documents/' + uid + '/');
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future _handleRefresh(){
    final Completer<void> completer = Completer<void>();

    Timer(const Duration(seconds: 1), () {
      completer.complete();
    });

    return completer.future.then<void>((futureFiles){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Refresh complete"),
          )
        );
    });
  }

  Widget buildFile(BuildContext context, FirebaseFile file) => ListTile(
        leading: ClipOval(
          child: Image.network(
            file.url,
            width: 52,
            height: 52,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          file.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.underline,
            color: Colors.blue,
          ),
        ),
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ImagePage(file: file),
        )),
      );

  Widget buildHeader(int length) => ListTile(
        tileColor: Colors.blue,
        leading: Container(
          width: 52,
          height: 52,
          child: Icon(
            Icons.file_copy,
            color: Colors.white,
          ),
        ),
        title: Text(
          '$length Files',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      );


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        _authBloc = AuthBloc();
        return _authBloc;
      },
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is UnAuthState) {
            return const LoginTest();
          }
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.cyan,
              title: const Text("My Documents"),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 3.0),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: TextButton(
                        onPressed: () {
                          _authBloc.add(SignOutAuthEvent());
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.red),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ))),
                        child: const Text(
                          'Log out',
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                )
              ],
            ),
            body: FutureBuilder<List<FirebaseFile>>(
                  future: futureFiles,
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Center(child: CircularProgressIndicator());
                      default:
                        if (snapshot.hasError) {
                          return const Center(child: Text('Some error occurred!'));
                        } else {
                          final files = snapshot.data!;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              buildHeader(files.length),
                              const SizedBox(height: 12),
                              Expanded(
                                child: LiquidPullToRefresh(
                                  key: _refreshIndicatorKey,
                                  onRefresh: _handleRefresh,
                                  child: ListView.builder(
                                    itemCount: files.length,
                                    itemBuilder: (context, index) {
                                      final file = files[index];
                                              
                                      return buildFile(context, file);
                                        
                                    },
                                  ),
                                ),
                             
                              ),
                              Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    ListView(
                                      shrinkWrap: true,
                                      padding: const EdgeInsets.all(20),
                                      children: [
                                        ButtonBar(
                                            alignment: MainAxisAlignment.center,
                                            children: [
                                              IconButton(
                                                  onPressed: () async {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                const ImageFilter()));
                                                  },
                                                  icon: Icon(Icons.scanner,
                                                      color: Colors.cyan, size: 50))
                                            ]),
                                      ],
                                    ),
                                  ]),
                            ],
                          );
                        }
                    }
                  },
                ),
            
            
          );
        },
      ),
    );
  }
}


