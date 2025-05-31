import 'dart:developer';
import 'package:admin_v4/core/auth/auth_notifier.dart';
import 'package:admin_v4/core/data/local/hive/hive_notifier.dart';
import 'package:admin_v4/core/environment/environment_notifier.dart';
import 'package:admin_v4/core/pocketbase/pocketbase_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_startup_notifier.g.dart';

/// Advanced app startup notifier with retry capability
@riverpod
class AppStartupNotifier extends _$AppStartupNotifier {
  @override
  Future<void> build() async {
    // Initially, perform the complex initialization logic
    await _complexInitializationLogic();
  }

  Future<void> _complexInitializationLogic() async {
    try {
      log('Starting complex app initialization...');
      ref.read(environmentNotifierProvider.notifier);
      
      // Initialize Hive first and wait for it to complete
      log('Waiting for Hive initialization...');
      ref.read(pocketbaseNotifierProvider);
      await ref.read(hiveNotifierProvider.future);
      
      // Check the actual provider state
      // final hiveState = ref.read(hiveNotifierProvider);
      // log('Hive provider state: ${hiveState.runtimeType}');
      
      // // If there's an error in the provider, throw it
      // hiveState.when(
      //   data: (_) => log('Hive provider is in data state'),
      //   loading: () => throw StateError('Hive provider is still loading'),
      //   error: (error, stack) => throw error,
      // );
      
      // Small delay to ensure proper state synchronization
      // await Future.delayed(const Duration(milliseconds: 100));
      
      log('Hive initialization completed');
      
      // Initialize other services
      ref.read(authNotifierProvider.notifier);
      
      
      // // Simulate checking for first-time setup
      // log('Checking first-time setup...');
      // final isFirstTimeValue = hiveNotifier.get<String>('is_first_time');
      // final isFirstTime = isFirstTimeValue == 'true';
      // if (isFirstTime) {
      //   log('First time setup detected');
      //   await _performFirstTimeSetup(hiveNotifier);
      // }
      
      // // Simulate loading user preferences
      // await _loadUserPreferences(hiveNotifier);
      
      // Simulate network connectivity check
      await _checkNetworkConnectivity();
      
      // Add more initialization steps here:
      // - Database migrations
      // - Cache warming
      // - Feature flag fetching
      // - Authentication token validation
      
      log('Complex app initialization completed successfully');
    } catch (e, stackTrace) {
      log('Complex app initialization failed: $e', stackTrace: stackTrace);
      rethrow;
    }
  }

  // Future<void> _performFirstTimeSetup(HiveNotifier hiveNotifier) async {
  //   // Simulate first-time setup tasks
  //   await Future.delayed(const Duration(milliseconds: 500));
  //   await hiveNotifier.put('is_first_time', 'false');
  //   await hiveNotifier.put('app_version', '1.0.0');
  //   log('First-time setup completed');
  // }

  // Future<void> _loadUserPreferences(HiveNotifier hiveNotifier) async {
  //   // Simulate loading user preferences
  //   await Future.delayed(const Duration(milliseconds: 300));
  //   final theme = hiveNotifier.get<String>('theme');
  //   final language = hiveNotifier.get<String>('language');
  //   log('User preferences loaded: theme=$theme, language=$language');
  // }

  Future<void> _checkNetworkConnectivity() async {
    // Simulate network connectivity check
    await Future.delayed(const Duration(milliseconds: 200));
    
    // Uncomment to simulate a network error for testing retry functionality:
    // throw Exception('Network connectivity check failed');
    
    log('Network connectivity verified');
  }

  /// Retry the initialization process
  Future<void> retry() async {
    log('Retrying app initialization...');
    // Use AsyncValue.guard to handle errors gracefully
    state = await AsyncValue.guard(() async {
      await _complexInitializationLogic();
    });
  }
} 