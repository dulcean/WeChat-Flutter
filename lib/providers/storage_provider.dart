// import 'dart:io';

// import 'package:WeChat/providers/base_providers.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:path/path.dart';

// class StorageProvider extends BaseStorageProvider {
//   final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
//   @override
//   void dispose() {}

//   @override
//   Future<String> uploadImage(File file, String path) async {
//     String fileName = basename(file.path);
//     final miliSecs = DateTime.now().millisecondsSinceEpoch;
//     final reference = firebaseStorage.ref().child('$path/$miliSecs\_$fileName');
//     String uploadPath = reference.fullPath;
//     print('uploading to $uploadPath');
//     final uploadTask = reference.putFile(file);
//     final result = await uploadTask.whenComplete(()=>{});
//     String url = await result.ref.getDownloadURL();
//     return url;
//   }
// }
