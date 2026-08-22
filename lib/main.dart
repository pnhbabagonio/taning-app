// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taning/app/app.dart';
import 'package:taning/app/bootstrap.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize services
  await bootstrap();
  
  runApp(
    const ProviderScope(
      child: TaningApp(),
    ),
  );
}