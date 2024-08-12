// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'constructor_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$constructorRepositoryHash() =>
    r'f6d1de8c994c9cdf8d3c7c71d92362202e1d8b05';

/// See also [constructorRepository].
@ProviderFor(constructorRepository)
final constructorRepositoryProvider = Provider<ConstructorRepository>.internal(
  constructorRepository,
  name: r'constructorRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$constructorRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ConstructorRepositoryRef = ProviderRef<ConstructorRepository>;
String _$constructorsListStreamHash() =>
    r'edf9876c43d4f625718582fb53b7189dbb937897';

/// See also [constructorsListStream].
@ProviderFor(constructorsListStream)
final constructorsListStreamProvider =
    AutoDisposeStreamProvider<List<ConstructorIslamabad>>.internal(
  constructorsListStream,
  name: r'constructorsListStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$constructorsListStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ConstructorsListStreamRef
    = AutoDisposeStreamProviderRef<List<ConstructorIslamabad>>;
String _$constructorsListFutureHash() =>
    r'7e18f0e761a42d776981f7719325ed27fcc07668';

/// See also [constructorsListFuture].
@ProviderFor(constructorsListFuture)
final constructorsListFutureProvider =
    AutoDisposeFutureProvider<List<ConstructorIslamabad>>.internal(
  constructorsListFuture,
  name: r'constructorsListFutureProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$constructorsListFutureHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ConstructorsListFutureRef
    = AutoDisposeFutureProviderRef<List<ConstructorIslamabad>>;
String _$constructorFutureHash() => r'3ed99e606d566e1f5a6f5010c3a63fe7bc249fc8';

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

/// See also [constructorFuture].
@ProviderFor(constructorFuture)
const constructorFutureProvider = ConstructorFutureFamily();

/// See also [constructorFuture].
class ConstructorFutureFamily
    extends Family<AsyncValue<ConstructorIslamabad?>> {
  /// See also [constructorFuture].
  const ConstructorFutureFamily();

  /// See also [constructorFuture].
  ConstructorFutureProvider call(
    String id,
  ) {
    return ConstructorFutureProvider(
      id,
    );
  }

  @override
  ConstructorFutureProvider getProviderOverride(
    covariant ConstructorFutureProvider provider,
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
  String? get name => r'constructorFutureProvider';
}

/// See also [constructorFuture].
class ConstructorFutureProvider
    extends AutoDisposeFutureProvider<ConstructorIslamabad?> {
  /// See also [constructorFuture].
  ConstructorFutureProvider(
    String id,
  ) : this._internal(
          (ref) => constructorFuture(
            ref as ConstructorFutureRef,
            id,
          ),
          from: constructorFutureProvider,
          name: r'constructorFutureProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$constructorFutureHash,
          dependencies: ConstructorFutureFamily._dependencies,
          allTransitiveDependencies:
              ConstructorFutureFamily._allTransitiveDependencies,
          id: id,
        );

  ConstructorFutureProvider._internal(
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
    FutureOr<ConstructorIslamabad?> Function(ConstructorFutureRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ConstructorFutureProvider._internal(
        (ref) => create(ref as ConstructorFutureRef),
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
  AutoDisposeFutureProviderElement<ConstructorIslamabad?> createElement() {
    return _ConstructorFutureProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ConstructorFutureProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ConstructorFutureRef
    on AutoDisposeFutureProviderRef<ConstructorIslamabad?> {
  /// The parameter `id` of this provider.
  String get id;
}

class _ConstructorFutureProviderElement
    extends AutoDisposeFutureProviderElement<ConstructorIslamabad?>
    with ConstructorFutureRef {
  _ConstructorFutureProviderElement(super.provider);

  @override
  String get id => (origin as ConstructorFutureProvider).id;
}

String _$constructorHash() => r'ce454546557a4ab7c116a9a17878ce7446de4fcd';

/// See also [constructor].
@ProviderFor(constructor)
const constructorProvider = ConstructorFamily();

/// See also [constructor].
class ConstructorFamily extends Family<AsyncValue<ConstructorIslamabad?>> {
  /// See also [constructor].
  const ConstructorFamily();

  /// See also [constructor].
  ConstructorProvider call(
    String id,
  ) {
    return ConstructorProvider(
      id,
    );
  }

  @override
  ConstructorProvider getProviderOverride(
    covariant ConstructorProvider provider,
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
  String? get name => r'constructorProvider';
}

/// See also [constructor].
class ConstructorProvider
    extends AutoDisposeStreamProvider<ConstructorIslamabad?> {
  /// See also [constructor].
  ConstructorProvider(
    String id,
  ) : this._internal(
          (ref) => constructor(
            ref as ConstructorRef,
            id,
          ),
          from: constructorProvider,
          name: r'constructorProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$constructorHash,
          dependencies: ConstructorFamily._dependencies,
          allTransitiveDependencies:
              ConstructorFamily._allTransitiveDependencies,
          id: id,
        );

  ConstructorProvider._internal(
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
    Stream<ConstructorIslamabad?> Function(ConstructorRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ConstructorProvider._internal(
        (ref) => create(ref as ConstructorRef),
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
    return _ConstructorProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ConstructorProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ConstructorRef on AutoDisposeStreamProviderRef<ConstructorIslamabad?> {
  /// The parameter `id` of this provider.
  String get id;
}

class _ConstructorProviderElement
    extends AutoDisposeStreamProviderElement<ConstructorIslamabad?>
    with ConstructorRef {
  _ConstructorProviderElement(super.provider);

  @override
  String get id => (origin as ConstructorProvider).id;
}

String _$constructorsListSearchHash() =>
    r'8a7273a5f41fcc74a55453a962e74e080b80aa42';

/// See also [constructorsListSearch].
@ProviderFor(constructorsListSearch)
const constructorsListSearchProvider = ConstructorsListSearchFamily();

/// See also [constructorsListSearch].
class ConstructorsListSearchFamily
    extends Family<AsyncValue<List<ConstructorIslamabad>>> {
  /// See also [constructorsListSearch].
  const ConstructorsListSearchFamily();

  /// See also [constructorsListSearch].
  ConstructorsListSearchProvider call(
    String query,
  ) {
    return ConstructorsListSearchProvider(
      query,
    );
  }

  @override
  ConstructorsListSearchProvider getProviderOverride(
    covariant ConstructorsListSearchProvider provider,
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
  String? get name => r'constructorsListSearchProvider';
}

/// See also [constructorsListSearch].
class ConstructorsListSearchProvider
    extends AutoDisposeFutureProvider<List<ConstructorIslamabad>> {
  /// See also [constructorsListSearch].
  ConstructorsListSearchProvider(
    String query,
  ) : this._internal(
          (ref) => constructorsListSearch(
            ref as ConstructorsListSearchRef,
            query,
          ),
          from: constructorsListSearchProvider,
          name: r'constructorsListSearchProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$constructorsListSearchHash,
          dependencies: ConstructorsListSearchFamily._dependencies,
          allTransitiveDependencies:
              ConstructorsListSearchFamily._allTransitiveDependencies,
          query: query,
        );

  ConstructorsListSearchProvider._internal(
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
    FutureOr<List<ConstructorIslamabad>> Function(
            ConstructorsListSearchRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ConstructorsListSearchProvider._internal(
        (ref) => create(ref as ConstructorsListSearchRef),
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
  AutoDisposeFutureProviderElement<List<ConstructorIslamabad>> createElement() {
    return _ConstructorsListSearchProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ConstructorsListSearchProvider && other.query == query;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, query.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ConstructorsListSearchRef
    on AutoDisposeFutureProviderRef<List<ConstructorIslamabad>> {
  /// The parameter `query` of this provider.
  String get query;
}

class _ConstructorsListSearchProviderElement
    extends AutoDisposeFutureProviderElement<List<ConstructorIslamabad>>
    with ConstructorsListSearchRef {
  _ConstructorsListSearchProviderElement(super.provider);

  @override
  String get query => (origin as ConstructorsListSearchProvider).query;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
