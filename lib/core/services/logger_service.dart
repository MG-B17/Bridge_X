import 'package:flutter/foundation.dart';

enum LogLevel { verbose, debug, info, warning, error, wtf }

class LoggerService {
  static const String _tag = '🚀 BridgeX';

  static void log(
    String message, {
    LogLevel level = LogLevel.debug,
    dynamic error,
    StackTrace? stackTrace,
    String? tag,
  }) {
    if (!kDebugMode) return;

    final logTag = tag ?? _tag;
    final timestamp = DateTime.now().toString().split('.')[0];
    final prefix = _getLevelPrefix(level);

    final output = '[$timestamp] $prefix [$logTag] $message';

    debugPrint(output);

    if (error != null) {
      debugPrint('Error: $error');
    }

    if (stackTrace != null) {
      debugPrintStack(stackTrace: stackTrace, label: 'Stack Trace');
    }
  }

  static void verbose(String message, {String? tag}) =>
      log(message, level: LogLevel.verbose, tag: tag);

  static void debug(String message, {String? tag}) =>
      log(message, level: LogLevel.debug, tag: tag);

  static void info(String message, {String? tag}) =>
      log(message, level: LogLevel.info, tag: tag);

  static void warning(String message, {String? tag}) =>
      log(message, level: LogLevel.warning, tag: tag);

  static void error(
    String message, {
    dynamic exception,
    StackTrace? stackTrace,
    String? tag,
  }) =>
      log(
        message,
        level: LogLevel.error,
        error: exception,
        stackTrace: stackTrace,
        tag: tag,
      );

  static void wtf(
    String message, {
    dynamic exception,
    StackTrace? stackTrace,
    String? tag,
  }) =>
      log(
        message,
        level: LogLevel.wtf,
        error: exception,
        stackTrace: stackTrace,
        tag: tag,
      );

  static String _getLevelPrefix(LogLevel level) {
    switch (level) {
      case LogLevel.verbose:
        return '📝 V';
      case LogLevel.debug:
        return '🐛 D';
      case LogLevel.info:
        return 'ℹ️  I';
      case LogLevel.warning:
        return '⚠️  W';
      case LogLevel.error:
        return '❌ E';
      case LogLevel.wtf:
        return '💥 WTF';
    }
  }
}
