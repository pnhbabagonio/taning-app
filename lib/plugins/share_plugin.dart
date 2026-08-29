import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:taning/core/services/logger.dart';
import 'package:taning/features/tanings/domain/entities/taning.dart';

/// Plugin for native sharing with image generation
class SharePlugin {
  static const MethodChannel _channel = MethodChannel('com.taning.app/share');

  static Future<void> initialize() async {
    _channel.setMethodCallHandler(_handleMethodCall);
    LoggerService.info('SharePlugin initialized');
  }

  static Future<dynamic> _handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'shareImage':
        return _handleShareImage(call.arguments);
      case 'generateShareImage':
        return _generateShareImage(call.arguments);
      default:
        throw PlatformException(
          code: 'Unimplemented',
          details: 'Method ${call.method} not implemented',
        );
    }
  }

  /// Share a Taning as an image
  static Future<void> shareTaningAsImage(Taning taning, BuildContext context) async {
    try {
      // Generate the image
      final imageBytes = await generateTaningImage(taning, context);
      
      // Save to temporary file
      final tempDir = await getTemporaryDirectory();
      final filePath = '${tempDir.path}/taning_share_${taning.id}.png';
      final file = File(filePath);
      await file.writeAsBytes(imageBytes);
      
      // Share the image
      await SharePlus.instance.share(
        ShareParams(
          files: [XFile(file.path)],
          text: '${taning.title} - Know your taning!',
          subject: 'My Taning: ${taning.title}',
        ),
      );
      
      // Clean up
      await file.delete();
    } catch (e) {
      LoggerService.error('Failed to share Taning as image: $e');
      // Fallback to text sharing
      await SharePlus.instance.share(
        ShareParams(
          text: '🎯 ${taning.title}\n\nKnow your taning.\n---\nTaning - Make time visible.',
          subject: 'My Taning: ${taning.title}',
        ),
      );
    }
  }

  /// Generate an image for sharing
  static Future<Uint8List> generateTaningImage(Taning taning, BuildContext context) async {
    try {
      // Get screen size for the image
      final screenSize = MediaQuery.of(context).size;
      final width = screenSize.width.toInt();
      final height = (width * 0.8).toInt(); // 5:4 aspect ratio
      
      // Create a recorder and canvas
      final recorder = ui.PictureRecorder();
      final canvas = Canvas(recorder);
      
      // Draw the share card
      await _drawShareCard(canvas, taning, Size(width.toDouble(), height.toDouble()));
      
      // End recording
      final picture = recorder.endRecording();
      final image = await picture.toImage(width, height);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      
      if (byteData == null) {
        throw Exception('Failed to generate image');
      }
      
      return byteData.buffer.asUint8List();
    } catch (e) {
      LoggerService.error('Failed to generate share image: $e');
      rethrow;
    }
  }

  static Future<void> _drawShareCard(Canvas canvas, Taning taning, Size size) async {
    final color = taning.color.toColor();
    final paint = Paint()..color = color;
    
    // Draw background
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
    
    // Draw card inner area
    final innerPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.95)
      ..style = PaintingStyle.fill;
    final innerRect = Rect.fromLTWH(20, 20, size.width - 40, size.height - 40);
    canvas.drawRRect(
      RRect.fromRectAndCorners(
        innerRect,
        topLeft: const Radius.circular(16),
        topRight: const Radius.circular(16),
        bottomLeft: const Radius.circular(16),
        bottomRight: const Radius.circular(16),
      ),
      innerPaint,
    );
    
    // Draw icon (simplified)
    final iconPaint = Paint()..color = color;
    canvas.drawCircle(Offset(size.width / 2, 80), 30, iconPaint);
    
    // Draw title
    final titlePainter = TextPainter(
      text: TextSpan(
        text: taning.title,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    titlePainter.layout(maxWidth: size.width - 80);
    titlePainter.paint(
      canvas,
      Offset((size.width - titlePainter.width) / 2, 130),
    );
    
    // Draw countdown placeholder
    final countdownPainter = TextPainter(
      text: const TextSpan(
        text: '14 DAYS',
        style: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          color: Color(0xFF4F46E5),
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    countdownPainter.layout(maxWidth: size.width - 80);
    countdownPainter.paint(
      canvas,
      Offset((size.width - countdownPainter.width) / 2, 180),
    );
    
    // Draw brand text
    final brandPainter = TextPainter(
      text: const TextSpan(
        text: 'TANING',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
          letterSpacing: 2,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    brandPainter.layout(maxWidth: size.width - 80);
    brandPainter.paint(
      canvas,
      Offset((size.width - brandPainter.width) / 2, size.height - 40),
    );
  }

  static Future<dynamic> _handleShareImage(Map<String, dynamic>? args) async {
    // Handle native share image request
    return {'success': true};
  }

  static Future<dynamic> _generateShareImage(Map<String, dynamic>? args) async {
    // Handle native image generation request
    return {'success': true};
  }
}