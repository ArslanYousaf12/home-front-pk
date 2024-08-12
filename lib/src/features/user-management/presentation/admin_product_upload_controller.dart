import 'package:home_front_pk/src/features/dashboard/domain/constructor.dart';
import 'package:home_front_pk/src/features/user-management/application/image_upload_service.dart';

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
      await ref.read(imageUploadServiceProvider).uploadProduct(constructor);
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
