import 'package:flutter/material.dart';
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
  
  
  File? _doc;
  String? _uploadedFileURL; 
  //img
  Future<File?> _getImage() async {
    final pickedImage = await ImagePicker().pickImage(
        source: ImageSource.camera,
        maxHeight: 720,
        maxWidth: 720,
        imageQuality: 85);
    if(pickedImage!=null){
      setState(() {
      _doc = File(pickedImage.path);
      });
      return File(pickedImage.path);

    }else{
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
    return Scaffold(
      appBar: new AppBar(
        title: new Text("My Documents"),
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
                    onPressed: () async{
                      _doc = await _getImage();
                    },
                    icon: Icon(Icons.scanner, color: Colors.cyan, size: 50))
              ]),
            ),
          ],
        ),
      ),
    );
  }
}