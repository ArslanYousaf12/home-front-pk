import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:home_front_pk/src/features/dashboard/domain/constructor.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'image_upload_repository.g.dart';

/// Class for uploading images to Firebase Storage
class ImageUploadRepository {
  ImageUploadRepository(this._storage);
  final FirebaseStorage _storage;

  /// Upload an image asset to Firebase Storage and returns the download URL
  Future<String> uploadProductImageFromAsset(
      String assetPath, ConstructorID constructorId) async {
    //loading assets from assets bundle
    final byteData = await rootBundle.load(assetPath);
    // Extracting file name from asset path
    final component = assetPath.split('/');
    final filename = component[1];
    //getting the reference of the file after uploading
    final result = await _uploadAsset(byteData, filename);

    return result.ref.getDownloadURL();
  }

  UploadTask _uploadAsset(ByteData byteData, String filename) {
    final bytes = byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);
    final ref = _storage.ref('sellers/$filename');
    return ref.putData(
      bytes,
      SettableMetadata(contentType: 'image/jpeg'),
    );
  }

  Future<void> deleteConstructorImage(String imageUrl) async {
    final ref = _storage.refFromURL(imageUrl);
    await ref.delete();
  }
}

@riverpod
ImageUploadRepository imageUploadRepository(ImageUploadRepositoryRef ref) {
  return ImageUploadRepository(FirebaseStorage.instance);
}
