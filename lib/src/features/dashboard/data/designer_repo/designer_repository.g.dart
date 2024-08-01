// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'designer_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$designerRepositoryHash() =>
    r'a8ced19cb6419b0ffe164513b55a103181b1848d';

/// See also [designerRepository].
@ProviderFor(designerRepository)
final designerRepositoryProvider = Provider<DesignerRepository>.internal(
  designerRepository,
  name: r'designerRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$designerRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef DesignerRepositoryRef = ProviderRef<DesignerRepository>;
String _$designersListStreamHash() =>
    r'9aa4b22ed4acf9e2ff875bf462f460336f891863';

/// See also [designersListStream].
@ProviderFor(designersListStream)
final designersListStreamProvider =
    AutoDisposeStreamProvider<List<DesignerIslamabad>>.internal(
  designersListStream,
  name: r'designersListStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$designersListStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef DesignersListStreamRef
    = AutoDisposeStreamProviderRef<List<DesignerIslamabad>>;
String _$designersListFutureHash() =>
    r'3d8c8156472c6ad18a3e63408a0411715e2554b5';

/// See also [designersListFuture].
@ProviderFor(designersListFuture)
final designersListFutureProvider =
    AutoDisposeFutureProvider<List<DesignerIslamabad>>.internal(
  designersListFuture,
  name: r'designersListFutureProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$designersListFutureHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef DesignersListFutureRef
    = AutoDisposeFutureProviderRef<List<DesignerIslamabad>>;
String _$designerHash() => r'54c742e7c9e297cea8064403a602e7641c3b08fc';

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

/// See also [designer].
@ProviderFor(designer)
const designerProvider = DesignerFamily();

/// See also [designer].
class DesignerFamily extends Family<AsyncValue<DesignerIslamabad?>> {
  /// See also [designer].
  const DesignerFamily();

  /// See also [designer].
  DesignerProvider call(
    String id,
  ) {
    return DesignerProvider(
      id,
    );
  }

  @override
  DesignerProvider getProviderOverride(
    covariant DesignerProvider provider,
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
  String? get name => r'designerProvider';
}

/// See also [designer].
class DesignerProvider extends AutoDisposeStreamProvider<DesignerIslamabad?> {
  /// See also [designer].
  DesignerProvider(
    String id,
  ) : this._internal(
          (ref) => designer(
            ref as DesignerRef,
            id,
          ),
          from: designerProvider,
          name: r'designerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$designerHash,
          dependencies: DesignerFamily._dependencies,
          allTransitiveDependencies: DesignerFamily._allTransitiveDependencies,
          id: id,
        );

  DesignerProvider._internal(
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
    Stream<DesignerIslamabad?> Function(DesignerRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: DesignerProvider._internal(
        (ref) => create(ref as DesignerRef),
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
  AutoDisposeStreamProviderElement<DesignerIslamabad?> createElement() {
    return _DesignerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DesignerProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin DesignerRef on AutoDisposeStreamProviderRef<DesignerIslamabad?> {
  /// The parameter `id` of this provider.
  String get id;
}

class _DesignerProviderElement
    extends AutoDisposeStreamProviderElement<DesignerIslamabad?>
    with DesignerRef {
  _DesignerProviderElement(super.provider);

  @override
  String get id => (origin as DesignerProvider).id;
}

String _$designersListSearchHash() =>
    r'f12b03eaec202a9a09ad7a9ac237a58198c2d48d';

/// See also [designersListSearch].
@ProviderFor(designersListSearch)
const designersListSearchProvider = DesignersListSearchFamily();

/// See also [designersListSearch].
class DesignersListSearchFamily
    extends Family<AsyncValue<List<DesignerIslamabad>>> {
  /// See also [designersListSearch].
  const DesignersListSearchFamily();

  /// See also [designersListSearch].
  DesignersListSearchProvider call(
    String query,
  ) {
    return DesignersListSearchProvider(
      query,
    );
  }

  @override
  DesignersListSearchProvider getProviderOverride(
    covariant DesignersListSearchProvider provider,
  ) {
    return call(
      provider.query,
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
  String? get name => r'designersListSearchProvider';
}

/// See also [designersListSearch].
class DesignersListSearchProvider
    extends AutoDisposeFutureProvider<List<DesignerIslamabad>> {
  /// See also [designersListSearch].
  DesignersListSearchProvider(
    String query,
  ) : this._internal(
          (ref) => designersListSearch(
            ref as DesignersListSearchRef,
            query,
          ),
          from: designersListSearchProvider,
          name: r'designersListSearchProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$designersListSearchHash,
          dependencies: DesignersListSearchFamily._dependencies,
          allTransitiveDependencies:
              DesignersListSearchFamily._allTransitiveDependencies,
          query: query,
        );

  DesignersListSearchProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.query,
  }) : super.internal();

  final String query;

  @override
  Override overrideWith(
    FutureOr<List<DesignerIslamabad>> Function(DesignersListSearchRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: DesignersListSearchProvider._internal(
        (ref) => create(ref as DesignersListSearchRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        query: query,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<DesignerIslamabad>> createElement() {
    return _DesignersListSearchProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DesignersListSearchProvider && other.query == query;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, query.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin DesignersListSearchRef
    on AutoDisposeFutureProviderRef<List<DesignerIslamabad>> {
  /// The parameter `query` of this provider.
  String get query;
}

class _DesignersListSearchProviderElement
    extends AutoDisposeFutureProviderElement<List<DesignerIslamabad>>
    with DesignersListSearchRef {
  _DesignersListSearchProviderElement(super.provider);

  @override
  String get query => (origin as DesignersListSearchProvider).query;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
