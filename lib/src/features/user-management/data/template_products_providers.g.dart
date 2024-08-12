// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'template_products_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$templateConstructorsRepositoryHash() =>
    r'6151c8bba339efd83d5c71abeea835996bc6c69d';

/// See also [templateConstructorsRepository].
@ProviderFor(templateConstructorsRepository)
final templateConstructorsRepositoryProvider =
    AutoDisposeProvider<FakeConstructorRepository>.internal(
  templateConstructorsRepository,
  name: r'templateConstructorsRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$templateConstructorsRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef TemplateConstructorsRepositoryRef
    = AutoDisposeProviderRef<FakeConstructorRepository>;
String _$templateConstructorsListHash() =>
    r'b4da9b0a70f6f3f4610faf9b9d4e14b629e8b89c';

/// * A [StreamProvider] to return only the template products to be shown in the
/// * [AdminProductsAddScreen] widget
///
/// Copied from [templateConstructorsList].
@ProviderFor(templateConstructorsList)
final templateConstructorsListProvider =
    AutoDisposeStreamProvider<List<ConstructorIslamabad>>.internal(
  templateConstructorsList,
  name: r'templateConstructorsListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$templateConstructorsListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef TemplateConstructorsListRef
    = AutoDisposeStreamProviderRef<List<ConstructorIslamabad>>;
String _$templateProductHash() => r'91007253c79dd661f8ca7d8d727cce52ecd8e0ba';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [templateProduct].
@ProviderFor(templateProduct)
const templateProductProvider = TemplateProductFamily();

/// See also [templateProduct].
class TemplateProductFamily extends Family<AsyncValue<ConstructorIslamabad?>> {
  /// See also [templateProduct].
  const TemplateProductFamily();

  /// See also [templateProduct].
  TemplateProductProvider call(
    String id,
  ) {
    return TemplateProductProvider(
      id,
    );
  }

  @override
  TemplateProductProvider getProviderOverride(
    covariant TemplateProductProvider provider,
  ) {
    return call(
      provider.id,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'templateProductProvider';
}

/// See also [templateProduct].
class TemplateProductProvider
    extends AutoDisposeStreamProvider<ConstructorIslamabad?> {
  /// See also [templateProduct].
  TemplateProductProvider(
    String id,
  ) : this._internal(
          (ref) => templateProduct(
            ref as TemplateProductRef,
            id,
          ),
          from: templateProductProvider,
          name: r'templateProductProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$templateProductHash,
          dependencies: TemplateProductFamily._dependencies,
          allTransitiveDependencies:
              TemplateProductFamily._allTransitiveDependencies,
          id: id,
        );

  TemplateProductProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  Override overrideWith(
    Stream<ConstructorIslamabad?> Function(TemplateProductRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TemplateProductProvider._internal(
        (ref) => create(ref as TemplateProductRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<ConstructorIslamabad?> createElement() {
    return _TemplateProductProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TemplateProductProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin TemplateProductRef
    on AutoDisposeStreamProviderRef<ConstructorIslamabad?> {
  /// The parameter `id` of this provider.
  String get id;
}

class _TemplateProductProviderElement
    extends AutoDisposeStreamProviderElement<ConstructorIslamabad?>
    with TemplateProductRef {
  _TemplateProductProviderElement(super.provider);

  @override
  String get id => (origin as TemplateProductProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
