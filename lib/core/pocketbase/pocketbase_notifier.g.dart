// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pocketbase_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$pocketbaseClientHash() => r'6220d38a45a683a8392c0c85e706d4ca5d896cfd';

/// See also [PocketbaseClient].
@ProviderFor(PocketbaseClient)
final pocketbaseClientProvider =
    AutoDisposeNotifierProvider<PocketbaseClient, PocketBase>.internal(
      PocketbaseClient.new,
      name: r'pocketbaseClientProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$pocketbaseClientHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$PocketbaseClient = AutoDisposeNotifier<PocketBase>;
String _$pocketbaseNotifierHash() =>
    r'3945881f42367ad9539b638e3cbcd54282e6433d';

/// See also [PocketbaseNotifier].
@ProviderFor(PocketbaseNotifier)
final pocketbaseNotifierProvider =
    AsyncNotifierProvider<PocketbaseNotifier, PocketBase>.internal(
      PocketbaseNotifier.new,
      name: r'pocketbaseNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$pocketbaseNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$PocketbaseNotifier = AsyncNotifier<PocketBase>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
