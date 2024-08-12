// import 'package:home_front_pk/src/features/dashboard/data/constructor_repo/con.dart';
import 'package:flutter/material.dart';
import 'package:home_front_pk/src/features/dashboard/data/constructor_repo/constructor_repository.dart';
import 'package:home_front_pk/src/features/dashboard/domain/constructor.dart';
import 'package:home_front_pk/src/features/user-management/application/image_upload_service.dart';
import 'package:home_front_pk/src/routing/app_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
// part 'admin_product_edit_controller.g.dart';
part 'admin_product_edit_controller.g.dart';

@riverpod
class AdminProductEditController extends _$AdminProductEditController {
  @override
  FutureOr<void> build() {
    //no-op
  }
  Future<bool> updateConstructor(
    ConstructorIslamabad constructor,
    String title,
    String description,
    String location,
    String name,
  ) async {
    final constructorRepo = ref.read(constructorRepositoryProvider);
    final updatedConstructor = constructor.copyWith(
      title: title,
      detail: description,
      location: location,
      name: name,
    );
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => constructorRepo.updateConstructor(updatedConstructor),
    );
    final success = state.hasError == false;
    if (success) {
      ref.read(routerProvider).pop();
    }
    return success;
  }

  Future<void> deleteConstructor(ConstructorIslamabad constructor) async {
    final imageUploadService = ref.read(imageUploadServiceProvider);
    state = const AsyncLoading();
    final value = await AsyncValue.guard(
      () => imageUploadService.deleteConstructor(constructor),
    );
    debugPrint('controller function called');
    debugPrint('value: $value');
    final success = value.hasError == false;
    if (success) {
      ref.read(routerProvider).pop();
    }
  }
}
