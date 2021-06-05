import 'dart:io';

import 'package:demo_chat_app/controllers/ChatController.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class StorageService {
  StorageService._privateConstructor();
  static final StorageService instance = StorageService._privateConstructor();

  final storage = FirebaseStorage.instance;
  Future uploadFile(File _file) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference firebaseStorageRef = storage.ref().child('imgs/$fileName');
    UploadTask uploadTask = firebaseStorageRef.putFile(_file);
    uploadTask.whenComplete(() async {
      Get.find<ChatController>()
          .sendImage(await uploadTask.snapshot.ref.getDownloadURL());
    });
  }
}
