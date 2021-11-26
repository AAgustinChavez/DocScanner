import 'dart:async';
import 'dart:io';

import 'package:doc_scanner/auth/bloc/auth_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:photofilters/photofilters.dart';
import 'package:image/image.dart' as imageLib;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';

class ImageFilter extends StatefulWidget {
  const ImageFilter({Key? key}) : super(key: key); //const

  @override
  _ImageFilterState createState() => _ImageFilterState();
}

class _ImageFilterState extends State<ImageFilter> {
  late String fileName;
  List<Filter> filters = presetFiltersList;
  final picker = ImagePicker();
  File? imageFile;
  final FirebaseAuth auth = FirebaseAuth.instance;
  late AuthBloc _authBloc;
  File? _doc;
  String? _uploadedFileURL;
  final pdf = pw.Document();
  File? pdffile;

  Future getImage(context) async {
    final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.camera,
        maxHeight: 720,
        maxWidth: 720,
        imageQuality: 85);

    if (pickedFile != null) {
      imageFile = File(pickedFile.path);

      fileName = basename(imageFile!.path);
      var image = imageLib.decodeImage(await imageFile!.readAsBytes());
      image = imageLib.copyResize(image!, width: 600);
      Map imagefile = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PhotoFilterSelector(
            title: const Text("Document Filter"),
            image: image!,
            appBarColor:Colors.cyan,
            filters: presetFiltersList,
            filename: fileName,
            loader: Center(child: CircularProgressIndicator()),
            fit: BoxFit.contain,
          ),
        ),
      );

      if (imagefile != null && imagefile.containsKey('image_filtered')) {
        setState(() {
          imageFile = imagefile['image_filtered'];
          _doc = File(imageFile!.path);
        });
        print(imageFile!.path);
      }
    }
  }

  Future uploadFile(context) async {
    final User? user = auth.currentUser;
    final uid = user!.uid;

    Reference storageReference = FirebaseStorage.instance
        .ref()//Path.basename(_doc!.path)
        .child('documents/' + uid + '/' + DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now())+'.jpg');
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
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan,
          title: const Text('Scanned Document...'),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: const [
                Colors.cyan,
                Colors.white,
              ],
            ),
          ),
          child: Center(
            child: Container(
              child: imageFile == null
                  ? const Center(
                      child: Text('Missing document file.'),
                    )
                  : Image.file(File(imageFile!.path)),
            ),
          ),
        ),
        floatingActionButton:
            Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          FloatingActionButton(
            backgroundColor: Colors.red,
            child: Icon(Icons.add_a_photo),
            onPressed: () => getImage(context),
            tooltip: 'Pick Image',
            heroTag: null,
          ),
          SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            backgroundColor: Colors.red,
            child: Icon(Icons.upload_file),
            onPressed: () => {
              uploadFile(context),
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('File uploaded...')),
              ),
              Navigator.of(context).pop()
            },
            heroTag: null,
          )
        ]));
  }
}
