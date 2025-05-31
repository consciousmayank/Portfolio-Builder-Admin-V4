import 'package:admin_v4/core/data/local/hive/hive_notifier.dart';
import 'package:admin_v4/core/pocketbase/pocketbase_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'dart:developer';

part 'auth_notifier.g.dart';

@Riverpod(keepAlive: true)
class AuthNotifier extends _$AuthNotifier {
  static const String _authTokenKey = 'auth_token';
  static const String _isLoggedInKey = 'is_logged_in';

  @override
  bool build() {
    log('AuthNotifier: build() called');
    _loadAuthState();
    return false;
  }

  String get userName =>
      ref
          .read(pocketbaseNotifierProvider)
          .value
          ?.authStore
          .record
          ?.data['name'] ??
      '';
  String get userEmail =>
      ref
          .read(pocketbaseNotifierProvider)
          .value
          ?.authStore
          .record
          ?.data['email'] ??
      '';
  String get userAvatar =>
      ref
          .read(pocketbaseNotifierProvider)
          .value
          ?.authStore
          .record
          ?.data['avatar'] ??
      '';

  Future<void> _loadAuthState() async {
    try {
      log('AuthNotifier: Loading auth state...');

      final bool? isLoggedIn = ref
          .read(hiveNotifierProvider.notifier)
          .get<bool>(_isLoggedInKey, defaultValue: false);

      if (isLoggedIn != null && isLoggedIn == true) {
        state = await _verifyAuthToken();
        return;
      } else {
        state = false;
        return;
      }
    } catch (e) {
      log('AuthNotifier: Error loading auth state: $e');
      // Handle error - default to not logged in
      state = false;
    }
  }

  Future<void> login(String token) async {
    try {
      log('AuthNotifier: Attempting login...');
      await ref.read(hiveNotifierProvider.notifier).put(_authTokenKey, token);
      await ref.read(hiveNotifierProvider.notifier).put(_isLoggedInKey, true);
      state = true;
      log('AuthNotifier: Login successful, state set to: $state');
    } catch (e) {
      log('AuthNotifier: Login error: $e');
      // Handle error
      throw Exception('Failed to save authentication state: $e');
    }
  }

  Future<bool> loginViaEmailAndPassword(String email, String password) async {
    try {
      log('AuthNotifier: Attempting login via email and password...');
      final pb = ref.read(pocketbaseNotifierProvider).value;
      await pb?.collection('users').authWithPassword(email, password);
      await ref
          .read(hiveNotifierProvider.notifier)
          .put(_authTokenKey, pb?.authStore.token);
      await ref.read(hiveNotifierProvider.notifier).put(_isLoggedInKey, true);
      state = true;
      log('AuthNotifier: Login successful, state set to: $state');
      return true;
    } catch (e) {
      log('AuthNotifier: Login error: $e');
      state = false;
      throw Exception('Failed to login: $e');
    }
  }

  Future<void> logout() async {
    try {
      log('AuthNotifier: Attempting logout...');
      final pb = ref.read(pocketbaseNotifierProvider).value;
      pb?.authStore.clear();
      await ref.read(hiveNotifierProvider.notifier).clearAllData();
      
      state = false;
      log('AuthNotifier: Logout successful, state set to: $state');
    } catch (e) {
      log('AuthNotifier: Logout error: $e');
      state = false;
    }
  }

  Future<String?> getAuthToken() async {
    try {
      final pb = ref.read(pocketbaseNotifierProvider).value;
      return pb?.authStore.token;
    } catch (e) {
      return null;
    }
  }

  Future<bool> _verifyAuthToken() async {
    final pb = ref.read(pocketbaseNotifierProvider).value;
    String? token = ref
        .read(hiveNotifierProvider.notifier)
        .get<String>(_authTokenKey, defaultValue: '');
    if (token == null) {
      return false;
    } else {
      pb?.authStore.save(token ?? '', null);
      final authData = await pb?.collection('users').authRefresh();
      if (authData != null) {
        return true;
      } else {
        return false;
      }
    }
  }
}
