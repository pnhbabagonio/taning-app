import 'package:flutter/material.dart';
import 'package:taning/core/services/analytics_service.dart';
import 'package:taning/core/services/logger.dart';

class ErrorHandler {
  static void handleError(
    BuildContext context,
    dynamic error, {
    String? contextInfo,
    VoidCallback? onRetry,
  }) {
    LoggerService.error(
      'Error occurred',
      tag: 'ErrorHandler',
      error: error,
    );

    AnalyticsService().logError(
      error.toString(),
      context: contextInfo,
    );

    // Show user-friendly error message
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_getUserFriendlyMessage(error)),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 4),
          action: onRetry != null
              ? SnackBarAction(
                  label: 'Retry',
                  onPressed: onRetry,
                  textColor: Colors.white,
                )
              : null,
        ),
      );
    }
  }

  static String _getUserFriendlyMessage(dynamic error) {
    if (error is Exception) {
      return 'Something went wrong. Please try again.';
    }
    
    if (error is StateError) {
      return 'Data not found. Please refresh.';
    }
    
    if (error.toString().contains('permission')) {
      return 'Permission denied. Please check your settings.';
    }
    
    if (error.toString().contains('network')) {
      return 'Network error. Please check your connection.';
    }
    
    if (error.toString().contains('database')) {
      return 'Database error. Please restart the app.';
    }
    
    return 'An unexpected error occurred. Please try again.';
  }
}

/// Error boundary widget
class ErrorBoundary extends StatefulWidget {
  final Widget child;
  final Widget? fallback;

  const ErrorBoundary({
    super.key,
    required this.child,
    this.fallback,
  });

  @override
  State<ErrorBoundary> createState() => _ErrorBoundaryState();
}

class _ErrorBoundaryState extends State<ErrorBoundary> {
  dynamic _error;

  @override
  void didUpdateWidget(covariant ErrorBoundary oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.child != oldWidget.child) {
      setState(() {
        _error = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_error != null) {
      return widget.fallback ?? _buildDefaultFallback(context);
    }
    
    return ErrorWidget.builder(
      (error) {
        _error = error;
        if (mounted) {
          ErrorHandler.handleError(
            context,
            error,
            contextInfo: 'Widget error',
          );
        }
        return widget.fallback ?? _buildDefaultFallback(context);
      },
      child: widget.child,
    );
  }

  Widget _buildDefaultFallback(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            const Text(
              'Something went wrong',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Please try again or restart the app',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _error = null;
                });
              },
              child: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }
}