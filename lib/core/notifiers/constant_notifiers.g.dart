// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'constant_notifiers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$pocketBaseUrlHash() => r'a6cc95ab88cbe7ace095039e95b5720ac0e0e18e';

/// See also [pocketBaseUrl].
@ProviderFor(pocketBaseUrl)
final pocketBaseUrlProvider = AutoDisposeProvider<String>.internal(
  pocketBaseUrl,
  name: r'pocketBaseUrlProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$pocketBaseUrlHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PocketBaseUrlRef = AutoDisposeProviderRef<String>;
String _$imageUrlHash() => r'3f578cb083adf4826de2798fe75913c254e6a859';

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

/// See also [imageUrl].
@ProviderFor(imageUrl)
const imageUrlProvider = ImageUrlFamily();

/// See also [imageUrl].
class ImageUrlFamily extends Family<String> {
  /// See also [imageUrl].
  const ImageUrlFamily();

  /// See also [imageUrl].
  ImageUrlProvider call({
    required String collectionId,
    required String id,
    required String field,
  }) {
    return ImageUrlProvider(collectionId: collectionId, id: id, field: field);
  }

  @override
  ImageUrlProvider getProviderOverride(covariant ImageUrlProvider provider) {
    return call(
      collectionId: provider.collectionId,
      id: provider.id,
      field: provider.field,
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
  String? get name => r'imageUrlProvider';
}

/// See also [imageUrl].
class ImageUrlProvider extends AutoDisposeProvider<String> {
  /// See also [imageUrl].
  ImageUrlProvider({
    required String collectionId,
    required String id,
    required String field,
  }) : this._internal(
         (ref) => imageUrl(
           ref as ImageUrlRef,
           collectionId: collectionId,
           id: id,
           field: field,
         ),
         from: imageUrlProvider,
         name: r'imageUrlProvider',
         debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
             ? null
             : _$imageUrlHash,
         dependencies: ImageUrlFamily._dependencies,
         allTransitiveDependencies: ImageUrlFamily._allTransitiveDependencies,
         collectionId: collectionId,
         id: id,
         field: field,
       );

  ImageUrlProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.collectionId,
    required this.id,
    required this.field,
  }) : super.internal();

  final String collectionId;
  final String id;
  final String field;

  @override
  Override overrideWith(String Function(ImageUrlRef provider) create) {
    return ProviderOverride(
      origin: this,
      override: ImageUrlProvider._internal(
        (ref) => create(ref as ImageUrlRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        collectionId: collectionId,
        id: id,
        field: field,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<String> createElement() {
    return _ImageUrlProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ImageUrlProvider &&
        other.collectionId == collectionId &&
        other.id == id &&
        other.field == field;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, collectionId.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);
    hash = _SystemHash.combine(hash, field.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ImageUrlRef on AutoDisposeProviderRef<String> {
  /// The parameter `collectionId` of this provider.
  String get collectionId;

  /// The parameter `id` of this provider.
  String get id;

  /// The parameter `field` of this provider.
  String get field;
}

class _ImageUrlProviderElement extends AutoDisposeProviderElement<String>
    with ImageUrlRef {
  _ImageUrlProviderElement(super.provider);

  @override
  String get collectionId => (origin as ImageUrlProvider).collectionId;
  @override
  String get id => (origin as ImageUrlProvider).id;
  @override
  String get field => (origin as ImageUrlProvider).field;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
