import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taning/app/app.dart';
import 'package:taning/app/bootstrap.dart';
import 'package:taning/core/errors/error_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    await bootstrap();
  } catch (e) {
    // Log but continue - app can still run with limited functionality
    debugPrint('Bootstrap error: $e');
  }
  
  runApp(
    const ProviderScope(
      child: ErrorBoundary(
        child: TaningApp(),
      ),
    ),
  );
}