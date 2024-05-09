import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ServerException implements Exception {
  String message;

  ServerException(this.message);
}
