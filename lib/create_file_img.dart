import 'package:doc_scanner/auth/bloc/auth_bloc.dart';
import 'package:doc_scanner/login/login_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:path/path.dart' as Path;

class CreateFileIMG extends StatefulWidget {
  CreateFileIMG({Key? key}) : super(key: key);

  @override
  _CreateFileIMGState createState() => _CreateFileIMGState();
}

class _CreateFileIMGState extends State<CreateFileIMG> {
  late AuthBloc _authBloc;
  File? _doc;
  String? _uploadedFileURL;
  //img
  Future<File?> _getImage() async {
    final pickedImage = await ImagePicker().pickImage(
        source: ImageSource.camera,
        maxHeight: 720,
        maxWidth: 720,
        imageQuality: 85);
    if (pickedImage != null) {
      setState(() {
        _doc = File(pickedImage.path);
      });
      return File(pickedImage.path);
    } else {
      return null;
    }
  }

  Future uploadFile() async {
    Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('chats/${Path.basename(_doc!.path)}}');
    UploadTask uploadTask = storageReference.putFile(_doc!);
    await uploadTask.then((p0) => null);
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) {
      setState(() {
        _uploadedFileURL = fileURL;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        _authBloc = AuthBloc();
        return _authBloc;
      },
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
         
        },
        builder: (context, state) {
          if (state is UnAuthState) {
              return const LoginTest();
          }
          return Scaffold(
            appBar: new AppBar(
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
                              //side: const BorderSide(width: 1.0, color: Colors.black),
                            ))),
                        child: const Text(
                          'Log out',
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                )
              ],
            ),
            body: Center(
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.all(20),
                children: [
                  Container(
                    color: Colors.cyan[50],
                    child: ButtonBar(children: [
                      IconButton(
                          onPressed: () async {
                            _doc = await _getImage();
                          },
                          icon:
                              Icon(Icons.scanner, color: Colors.cyan, size: 50))
                    ]),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
