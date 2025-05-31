// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'go_router_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$goRouterHash() => r'f8b84bf8f6919a83f61c9b6683cb48a9201e37d7';

/// See also [goRouter].
@ProviderFor(goRouter)
final goRouterProvider = Provider<GoRouter>.internal(
  goRouter,
  name: r'goRouterProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$goRouterHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GoRouterRef = ProviderRef<GoRouter>;
String _$routerRefreshHash() => r'75ff4ba4b67af02fcdbd8b3d62f8e8fa218fd045';

/// See also [RouterRefresh].
@ProviderFor(RouterRefresh)
final routerRefreshProvider =
    AutoDisposeNotifierProvider<RouterRefresh, int>.internal(
      RouterRefresh.new,
      name: r'routerRefreshProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$routerRefreshHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$RouterRefresh = AutoDisposeNotifier<int>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
