import 'dart:io';

import 'package:home_front_pk/src/features/authentication/domain/app_user.dart';
import 'package:home_front_pk/src/features/profile/presentation/profile_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'profile_screen_controller.g.dart';

@riverpod
class ProfileScreenController extends _$ProfileScreenController {
  @override
  FutureOr<void> build() {
    //no-op
  }

  Future<String?> uploadImage(UserID userId, File imageFile) async {
    final repo = ref.read(profileImageUploadRepoProvider);
    final downloadUrl = await repo.uploadProfileImage(userId, imageFile);
    return downloadUrl;
  }
}
