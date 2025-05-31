import 'package:admin_v4/core/enums/environment_enum.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'environment_notifier.g.dart';

@riverpod
class EnvironmentNotifier extends _$EnvironmentNotifier {
  static const String kEnvDevelopment = 'Development';
  static const String kEnvProduction = 'Production';
  static const String kEnvStaging = 'Staging';

  String environment = String.fromEnvironment('ENVIRONMENT', defaultValue: kEnvDevelopment);
  String appPreferenceKey = String.fromEnvironment('APP_PREFERENCE_KEY', defaultValue: 'default_app_preference_key_32_chars');
  String baseUrl = String.fromEnvironment('BASE_URL');

  @override
  Environment build() {
    switch (environment) {
      case kEnvDevelopment:
        return Environment.development;
      case kEnvProduction:
        return Environment.production;
      case kEnvStaging:
        return Environment.staging;
      default:
        return Environment.development;
    }
  }
}
