import 'package:firebase_storage/firebase_storage.dart';
//Model for thefirebase file, to read the file as an object
class FirebaseFile {
  final Reference ref;
  final String name;
  final String url;

  const FirebaseFile({
    required this.ref,
    required this.name,
    required this.url,
  });
}
