import 'dart:io';
import 'package:doc_scanner/api/firebase_api.dart';
import 'package:doc_scanner/model/firebase_file.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';

class ImagePage extends StatelessWidget {
  final FirebaseFile file;
  
  //Image display builder when clicked view the image file with the share and download buttons
  const ImagePage({
    Key? key,
    required this.file,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isImage = ['.jpeg', '.jpg', '.png', '.pdf'].any(file.name.contains);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text(file.name),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () async {
              await FirebaseApi.downloadFile(file.ref);
              final dir = await getApplicationDocumentsDirectory();   
              await Share.shareFiles(
                ['${dir.path}/${file.name}'],
                text: file.name,
                subject: '',
              );
              
              final snackBar2 = SnackBar(
                content: Text('Shared ${file.name}'),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar2);
            },
          ),
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: () async {
              await FirebaseApi.downloadFile(file.ref);              
              final snackBar = SnackBar(
                content: Text('Downloaded ${file.name}...'),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: isImage
          ? Image.network(
              file.url,
              height: double.infinity,
              fit: BoxFit.cover,
            )
          : const Center(
              child: Text(
                'Cannot be displayed',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
    );
  }
}
