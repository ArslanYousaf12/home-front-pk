import 'package:home_front_pk/src/features/dashboard/data/constructor_repo/constructor_repository.dart';
import 'package:home_front_pk/src/features/dashboard/domain/constructor.dart';
import 'package:home_front_pk/src/features/user-management/data/image_upload_repository.dart';
import 'package:home_front_pk/src/routing/app_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'admin_product_upload_controller.g.dart';

@riverpod
class AdminProductUploadController extends _$AdminProductUploadController {
  @override
  FutureOr<void> build() {
    //no-op
  }

  Future<void> upload(ConstructorIslamabad constructor) async {
    try {
      state = const AsyncLoading();
      final downloadUrl = await ref
          .read(imageUploadRepositoryProvider)
          .uploadProductImageFromAsset(
            constructor.imageUrl,
            constructor.id,
          );
      ref.read(constructorRepositoryProvider).createConstructor(
            constructor.id,
            downloadUrl,
          );
      ref.read(routerProvider).goNamed(
        AppRoute.adminEditProduct.name,
        pathParameters: {
          'id': constructor.id,
        },
      );
    } catch (e, s) {
      state = AsyncError(e, s);
    }
  }
}
