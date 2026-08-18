// lib/app/bootstrap.dart
import 'package:firebase_core/firebase_core.dart';
import 'package:taning/core/services/logger.dart';
import 'package:taning/core/services/notification_service.dart';
import 'package:taning/database/app_database.dart';

Future<void> bootstrap() async {
  // Initialize logger
  LoggerService.initialize();
  
  // Initialize Firebase (optional)
  try {
    await Firebase.initializeApp();
    LoggerService.info('Firebase initialized');
  } catch (e) {
    LoggerService.warning('Firebase initialization failed: $e');
  }
  
  // Initialize database
  await AppDatabase.initialize();
  
  // Initialize notifications
  await NotificationService.instance.initialize();
  
  // Set timezone
  await TimezoneService.initialize();
  
  LoggerService.info('App initialized successfully');
}