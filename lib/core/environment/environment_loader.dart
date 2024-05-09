import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

part 'environment_keys.dart';

class EnvironmentLoader {
  static EnvironmentKeys? _keys;

  static EnvironmentKeys get keys {
    return _keys!;
  }

  static loadEnv() async {
    await dotenv.load(fileName: ".env");
    try {
      _keys = EnvironmentKeys.fromEnv(dotenv.env);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
