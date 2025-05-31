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
      
      log('Hive initialization completed');
      
      // Initialize and wait for authentication state to load
      log('Initializing authentication state...');
      final authNotifier = ref.read(authNotifierProvider.notifier);
      
      // Force authentication state loading and wait for it to complete
      // This ensures the auth state is properly loaded before the app starts
      await authNotifier.loadAuthState();
      log('Authentication state loaded successfully');
      
      // Simulate network connectivity check
      await _checkNetworkConnectivity();
      
      log('Complex app initialization completed successfully');
    } catch (e, stackTrace) {
      log('Complex app initialization failed: $e', stackTrace: stackTrace);
      rethrow;
    }
  }

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