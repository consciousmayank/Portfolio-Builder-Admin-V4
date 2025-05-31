# Hive Local Storage Implementation

This directory contains the Hive local storage implementation for the admin_v4 project. Hive is a lightweight and blazing fast key-value database written in pure Dart.

## Overview

The implementation consists of:

1. **HiveNotifier** - Main Hive initialization and management with encryption
2. **HiveUserService** - User-specific CRUD operations
3. **UserModel** - User data model with manual type adapter

## Features

- ✅ **Automatic Initialization** - Hive is initialized during app startup
- ✅ **Encryption** - AES encryption for mobile platforms (plain storage for web)
- ✅ **Type Safety** - Full type safety with manual type adapters
- ✅ **Riverpod Integration** - Seamless integration with Riverpod state management
- ✅ **Unified Storage** - Single encrypted box for all app data
- ✅ **CRUD Operations** - Complete user management with search and pagination
- ✅ **Error Handling** - Comprehensive error handling and logging

## File Structure

```
lib/core/data/local/hive/
├── hive_notifier.dart          # Main Hive initialization and management
├── hive_user_service.dart      # User CRUD operations
├── hive_notifier.g.dart        # Generated Riverpod provider
├── hive_user_service.g.dart    # Generated Riverpod provider
└── README.md                   # This documentation

lib/models/
└── user_model.dart             # User model with manual type adapter
```

## Usage

### 1. Basic Setup

The Hive implementation is automatically initialized during app startup through the `AppStartupNotifier`. No manual setup is required.

### 2. Using HiveNotifier

```dart
// Get the notifier
final hiveNotifier = ref.read(hiveNotifierProvider.notifier);

// Basic operations
await hiveNotifier.put('theme', 'dark');
final theme = hiveNotifier.get<String>('theme');

// With default values
final language = hiveNotifier.get<String>('language', defaultValue: 'en');

// Check if key exists
final hasTheme = hiveNotifier.containsKey('theme');

// Delete a key
await hiveNotifier.delete('theme');
```

### 3. Using HiveUserService

```dart
// Get the service
final userService = ref.read(hiveUserServiceProvider.notifier);

// Create a user
final user = UserModel(
  id: 'user_123',
  email: 'test@example.com',
  name: 'Test User',
  avatar: 'https://example.com/avatar.jpg',
  isActive: true,
  createdAt: DateTime.now(),
  updatedAt: DateTime.now(),
);

// Save user
await userService.saveUser(user);

// Get user
final retrievedUser = userService.getUser('user_123');

// Get all users
final allUsers = userService.getAllUsers();

// Search users
final searchResults = userService.searchUsersByName('Test');

// Delete user
await userService.deleteUser('user_123');
```

### 4. Watching for Changes

```dart
// Watch Hive initialization
final hiveState = ref.watch(hiveNotifierProvider);
hiveState.when(
  loading: () => CircularProgressIndicator(),
  error: (error, stack) => Text('Error: $error'),
  data: (_) => Text('Hive initialized'),
);

// Watch user service
final userServiceState = ref.watch(hiveUserServiceProvider);
userServiceState.when(
  loading: () => CircularProgressIndicator(),
  error: (error, stack) => Text('Error: $error'),
  data: (userBox) => Text('User service ready'),
);
```

## Available Methods

### HiveNotifier Methods

#### Basic Operations
- `put(String key, dynamic value)` - Save any value
- `get<T>(String key, {T? defaultValue})` - Get value with type safety
- `delete(String key)` - Delete a key
- `containsKey(String key)` - Check if key exists

#### Utility
- `clearAllData()` - Clear all data
- `closeAllBoxes()` - Close all Hive boxes
- `getAppBoxKeys()` - Get all keys in the app box

### HiveUserService Methods

#### CRUD Operations
- `saveUser(UserModel user)` - Save or update user
- `getUser(String userId)` - Get user by ID
- `getAllUsers()` - Get all users
- `updateUser(UserModel user)` - Update existing user
- `deleteUser(String userId)` - Delete user by ID
- `userExists(String userId)` - Check if user exists

#### Bulk Operations
- `saveUsers(List<UserModel> users)` - Save multiple users
- `clearAllUsers()` - Delete all users

#### Search & Filter
- `searchUsersByName(String query)` - Search by name
- `getUsersByEmail(String email)` - Get users by email
- `getActiveUsers()` - Get only active users
- `getUsersCreatedAfter(DateTime date)` - Get users by creation date

#### Pagination
- `getUsersPaginated({int page = 0, int limit = 10})` - Paginated results

#### Utility
- `getUsersCount()` - Get total user count
- `closeBox()` - Close user box

## Security Features

### Encryption
- **Mobile Platforms**: Data is encrypted using AES encryption with a key from your environment configuration
- **Web Platform**: Uses plain storage (encryption not supported in web browsers)
- **Key Management**: Encryption key is derived from `appPreferenceKey` in your environment settings

### Key Requirements
- The encryption key must be at least 32 characters
- If shorter, it will be padded with zeros
- If longer, it will be truncated to 32 characters

## Data Types Supported

Hive natively supports:
- `int`, `double`, `bool`, `String`
- `List`, `Map`
- `DateTime`
- `Uint8List`
- Custom objects with type adapters (like `UserModel`)

## Best Practices

### 1. Error Handling
Always wrap Hive operations in try-catch blocks:

```dart
try {
  await hiveNotifier.put('key', 'value');
} catch (e) {
  log('Failed to save data: $e');
}
```

### 2. Type Safety
Always specify types when retrieving data:

```dart
final theme = hiveNotifier.get<String>('theme');
final isEnabled = hiveNotifier.get<bool>('notifications');
```

### 3. Initialization
Always ensure Hive is initialized before use:

```dart
// In your UI
final hiveState = ref.watch(hiveNotifierProvider);
return hiveState.when(
  loading: () => CircularProgressIndicator(),
  error: (error, stack) => ErrorWidget(error),
  data: (_) => YourWidget(),
);
```

### 4. Cleanup
Close boxes when the app is terminated:

```dart
@override
void dispose() {
  ref.read(hiveNotifierProvider.notifier).closeAllBoxes();
  super.dispose();
}
```

## Performance Tips

1. **Unified Storage** - Single encrypted box reduces overhead
2. **Batch Operations** - Use `saveUsers()` for multiple users
3. **Pagination** - Use `getUsersPaginated()` for large datasets
4. **Type Specification** - Always specify types for better performance

## Troubleshooting

### Common Issues

1. **Initialization Error**
   ```
   Error: LateInitializationError: Field '_appBox' has not been initialized
   ```
   Solution: Ensure you await `hiveNotifierProvider.future` before accessing data

2. **Type Adapter Not Registered**
   ```
   Error: No adapter registered for type UserModel
   ```
   Solution: The adapter is automatically registered in `HiveNotifier`

3. **Encryption Key Error**
   ```
   Error: Invalid encryption key
   ```
   Solution: Ensure your `appPreferenceKey` in environment settings is properly set

4. **Data Corruption**
   ```
   Error: Failed to read data
   ```
   Solution: Clear the box or delete Hive files and restart

### Debug Information

Enable logging to see Hive operations:

```dart
import 'dart:developer';

// All Hive operations are logged with log() function
```

## Migration Guide

If you need to migrate from other storage solutions:

### From SharedPreferences
```dart
// Old
final prefs = await SharedPreferences.getInstance();
await prefs.setString('key', 'value');

// New
final hiveNotifier = ref.read(hiveNotifierProvider.notifier);
await hiveNotifier.put('key', 'value');
```

### From SQLite
```dart
// Old
await database.insert('users', user.toMap());

// New
final userService = ref.read(hiveUserServiceProvider.notifier);
await userService.saveUser(user);
```

## Contributing

When adding new models:

1. Create the model class extending `HiveObject`
2. Create a manual `TypeAdapter` 
3. Register the adapter in `HiveNotifier`
4. Create a service class following the `HiveUserService` pattern

## Dependencies

- `hive: ^2.2.3` - Core Hive package
- `hive_flutter: ^1.1.0` - Flutter integration
- `riverpod_annotation: ^2.6.1` - State management

Note: We're using manual type adapters instead of `hive_generator` to avoid dependency conflicts with `riverpod_lint`. 