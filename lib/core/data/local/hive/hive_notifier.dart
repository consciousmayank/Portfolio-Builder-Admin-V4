import 'dart:convert';
import 'dart:developer';
import 'package:admin_v4/core/environment/environment_notifier.dart';
import 'package:admin_v4/models/user_model.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'hive_notifier.g.dart';

@Riverpod(keepAlive: true)
class HiveNotifier extends _$HiveNotifier {
  final String appBox = 'appBox';
  late Uint8List _key;
  Box? _appBox; // Made nullable to handle initialization properly

  @override
  Future<void> build() async {
    await _initializeHive();
  }

  Future<HiveNotifier> _initializeHive() async {
    try {
      log('Initializing Hive database...');
      
      // Get and validate the environment key
      final envNotifier = ref.read(environmentNotifierProvider.notifier);
      final rawKey = envNotifier.appPreferenceKey;
      log('Got app preference key: ${rawKey.substring(0, 4)}...');
      
      final validKey = ensureValidKey(rawKey);
      _key = Uint8List.fromList(utf8.encode(validKey));
      log('Generated encryption key with length: ${_key.length}');
      
      // Initialize Hive
      log('Calling Hive.initFlutter()...');
      await Hive.initFlutter();
      log('Hive.initFlutter() completed');

      // Close existing box if it's open
      if (Hive.isBoxOpen(appBox)) {
        log('Closing existing box...');
        await Hive.box(appBox).close();
      }

      // Register type adapters before opening boxes
      if (!Hive.isAdapterRegistered(0)) {
        log('Registering UserModelAdapter...');
        Hive.registerAdapter(UserModelAdapter());
      } else {
        log('UserModelAdapter already registered');
      }

      log('Opening encrypted box...');
      _appBox = await _openBox(boxName: appBox);
      log('Box opened successfully: ${_appBox != null}');
      
      // Verify the box is working
      if (_appBox != null) {
        log('Testing box operations...');
        await _appBox!.put('init_test', 'success');
        final testResult = _appBox!.get('init_test');
        log('Box test result: $testResult');
        
        if (testResult != 'success') {
          throw StateError('Box test failed - could not store/retrieve data');
        }
      } else {
        throw StateError('Box is null after opening');
      }
      
      log('Hive database initialized successfully');
    } catch (e, stackTrace) {
      log('Failed to initialize Hive: $e', stackTrace: stackTrace);
      _appBox = null; // Ensure box is null if initialization fails
      rethrow;
    }
    return this;
  }

  Future<Box<T>> _openBox<T>({required String boxName}) async {
    try {
      if (kIsWeb) {
        // For web, we might want to use a non-encrypted box
        return await Hive.openBox<T>(boxName);
      } else {
        // For mobile, use encryption
        return await Hive.openBox<T>(boxName,
            encryptionCipher: HiveAesCipher(_key));
      }
    } catch (e) {
      log('Failed to open box $boxName: $e');
      rethrow;
    }
  }

  
  Future<void> clearAllData() async {
    if (_appBox != null) {
      await _appBox!.clear();
    }
  }

  Future<void> closeAllBoxes() async {
    if (_appBox != null) {
      await _appBox!.close();
      _appBox = null;
    }
  }

  // Get all keys from a specific box
  List<String> getAppBoxKeys() {
    if (_appBox == null) return [];
    return _appBox!.keys.cast<String>().toList();
  }

  String ensureValidKey(String key) {
    log('Processing key: "$key" (length: ${key.length})');
    
    // If key is empty, use a default
    if (key.isEmpty) {
      key = 'default_app_preference_key_32_chars';
      log('Key was empty, using default');
    }
    
    final bytes = utf8.encode(key);
    log('Key bytes length: ${bytes.length}');
    
    if (bytes.length >= 32) {
      final result = utf8.decode(bytes.take(32).toList());
      log('Key truncated to 32 bytes');
      return result;
    }
    
    // Pad with zeros if too short
    final paddedBytes = bytes + List.filled(32 - bytes.length, 0);
    final result = utf8.decode(paddedBytes);
    log('Key padded to 32 bytes');
    return result;
  }

  T? get<T>(String isLoggedInKey, {required T defaultValue}) {
    return _appBox?.get(isLoggedInKey, defaultValue: defaultValue);
  }

  Future<void> put<T>(String key, T value) async {
    await _appBox?.put(key, value);
  }
} 