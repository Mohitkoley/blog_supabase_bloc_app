part of 'environment_loader.dart';

class EnvironmentKeys {
  final String supabaseUrl;
  final String anonKey;

  EnvironmentKeys({
    required this.supabaseUrl,
    required this.anonKey,
  });

  factory EnvironmentKeys.fromEnv(Map<String, String> env) {
    return EnvironmentKeys(
      supabaseUrl: env['SUPABASEURL'] ?? '',
      anonKey: env['ANONKEY'] ?? '',
    );
  }
}
