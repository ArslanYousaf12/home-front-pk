import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_front_pk/src/features/dashboard/data/constructor_repo/constructor_repository.dart';
import 'package:home_front_pk/src/features/dashboard/domain/constructor.dart';
import 'package:home_front_pk/src/features/user-management/data/image_upload_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'image_upload_service.g.dart';

class ImageUploadService {
  const ImageUploadService(this.ref);
  final Ref ref;

  Future<void> uploadProduct(ConstructorIslamabad constructor) async {
    // upload to storage and return download URL
    final downloadUrl = await ref
        .read(imageUploadRepositoryProvider)
        .uploadProductImageFromAsset(constructor.imageUrl, constructor.id);

    // write to Cloud Firestore
    await ref
        .read(constructorRepositoryProvider)
        .createConstructor(constructor.id, downloadUrl);
  }

  Future<void> deleteConstructor(ConstructorIslamabad constructor) async {
    await ref
        .read(imageUploadRepositoryProvider)
        .deleteConstructorImage(constructor.imageUrl);
    await ref
        .read(constructorRepositoryProvider)
        .deleteConstructor(constructor.id);
  }
}

@riverpod
ImageUploadService imageUploadService(ImageUploadServiceRef ref) {
  return ImageUploadService(ref);
}
