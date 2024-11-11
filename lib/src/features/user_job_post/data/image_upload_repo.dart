// lib/data/repositories/storage_repository.dart
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class StorageRepository {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<List<String>> uploadJobImages(List<File> images, String jobId) async {
    List<String> imageUrls = [];

    try {
      for (var image in images) {
        final ref = _storage
            .ref()
            .child('jobs/$jobId/${DateTime.now().millisecondsSinceEpoch}');
        await ref.putFile(image);
        final url = await ref.getDownloadURL();
        imageUrls.add(url);
      }
      return imageUrls;
    } catch (e) {
      throw Exception('Failed to upload images: $e');
    }
  }

  Future<String> uploadChatImage(String chatId, File image) async {
    final ref = _storage
        .ref()
        .child('chats/$chatId/${DateTime.now().millisecondsSinceEpoch}');
    await ref.putFile(image);
    return await ref.getDownloadURL();
  }
}
