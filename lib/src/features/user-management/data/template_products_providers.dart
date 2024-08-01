import 'package:home_front_pk/src/features/dashboard/data/constructor_repo/fake_constructor_repo.dart';
import 'package:home_front_pk/src/features/dashboard/domain/constructor.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'template_products_providers.g.dart';

// A provider that returns the FakeProductsRepository
// (used to load template products data)
@riverpod
FakeConstructorRepository templateConstructorsRepository(
    TemplateConstructorsRepositoryRef ref) {
  return FakeConstructorRepository(addDelay: false);
}

/// * A [StreamProvider] to return only the template products to be shown in the
/// * [AdminProductsAddScreen] widget
@riverpod
Stream<List<ConstructorIslamabad>> templateConstructorsList(
    TemplateConstructorsListRef ref) {
  return ref
      .watch(templateConstructorsRepositoryProvider)
      .watchConstructorList();
  // TODO: uncomment the code below to return only the template products that
  // have not been uploaded yet
  // final templateProductsStream =
  //     ref.watch(templateProductsRepositoryProvider).watchProductsList();
  // final existingProductsStream =
  //     ref.watch(productsRepositoryProvider).watchProductsList();
  // return Rx.combineLatest2(templateProductsStream, existingProductsStream,
  //     (template, existing) {
  //   // return only the template products that have not been uploaded yet
  //   final existingProductIds = existing.map((product) => product.id).toList();
  //   return template
  //       .where((product) => !existingProductIds.contains(product.id))
  //       .toList();
  // });
}

@riverpod
Stream<ConstructorIslamabad?> templateProduct(
    TemplateProductRef ref, ConstructorID id) {
  return ref.watch(templateConstructorsRepositoryProvider).watchConstructor(id);
}
