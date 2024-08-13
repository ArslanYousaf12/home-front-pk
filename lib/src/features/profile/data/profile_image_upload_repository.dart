import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class ProfileImageUploadRepo {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String?> uploadProfileImage(String userId, File? imageFile) async {
    if (imageFile == null) return null;

    try {
      final ref = _storage.ref().child('profile_images').child('$userId.jpg');
      await ref.putFile(imageFile);
      return await ref.getDownloadURL();
    } catch (e) {
      print('Error uploading profile image: $e');
      return null;
    }
  }

  Future<String?> fetchProfileImage(String userId) async {
    try {
      final ref = _storage.ref().child('profile_images').child('$userId.jpg');
      return await ref.getDownloadURL();
    } catch (e) {
      print('Error fetching profile image: $e');
      return null;
    }
  }

  Future<bool> deleteProfileImage(String userId) async {
    try {
      final ref = _storage.ref().child('profile_images').child('$userId.jpg');
      await ref.delete();
      return true;
    } catch (e) {
      print('Error deleting profile image: $e');
      return false;
    }
  }
}
