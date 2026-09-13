import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taning/app/app.dart';
import 'package:taning/app/bootstrap.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Create the Riverpod container first
  final container = ProviderContainer();

  // Pass it to bootstrap so it can read providers
  await bootstrap(container);

  runApp(
    // Use UncontrolledProviderScope to share the same container
    UncontrolledProviderScope(
      container: container,
      child: const TaningApp(),
    ),
  );
}