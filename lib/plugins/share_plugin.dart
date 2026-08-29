import 'dart:io'; // Add this for File
import 'dart:ui' as ui; // Add this for ui.PictureRecorder, etc.
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
      final imageBytes = await generateTaningImage(taning, context);
      
      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/taning_share_${taning.id}.png');
      await file.create(recursive: true);
      await file.writeAsBytes(imageBytes);
      
      await Share.shareXFiles(
        [XFile(file.path)],
        text: '${taning.title} - Know your taning!',
        subject: 'My Taning: ${taning.title}',
      );
      
      await file.delete();
    } catch (e) {
      LoggerService.error('Failed to share Taning as image: $e');
      try {
        await Share.share(
          '🎯 ${taning.title}\n\nKnow your taning.\n---\nTaning - Make time visible.',
          subject: 'My Taning: ${taning.title}',
        );
      } catch (_) {}
    }
  }

  /// Generate an image for sharing
  static Future<Uint8List> generateTaningImage(Taning taning, BuildContext context) async {
    try {
      final screenSize = MediaQuery.of(context).size;
      final width = screenSize.width.toInt();
      final height = (width * 0.8).toInt();
      
      final recorder = ui.PictureRecorder();
      final canvas = Canvas(recorder);
      
      await _drawShareCard(canvas, taning, Size(width.toDouble(), height.toDouble()));
      
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
    
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
    
    final innerPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.95)
      ..style = PaintingStyle.fill;
    
    final innerRect = Rect.fromLTWH(20, 20, size.width - 40, size.height - 40);
    final innerRRect = RRect.fromRectAndRadius(
      innerRect,
      const Radius.circular(16),
    );
    canvas.drawRRect(innerRRect, innerPaint);
    
    final iconPaint = Paint()..color = color;
    canvas.drawCircle(Offset(size.width / 2, 80), 30, iconPaint);
    
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
    return {'success': true};
  }

  static Future<dynamic> _generateShareImage(Map<String, dynamic>? args) async {
    return {'success': true};
  }
}