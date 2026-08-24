enum Environment {
  development,
  staging,
  production,
}

class AppConfig {
  const AppConfig._();

  static Environment get current {
    return const String.fromEnvironment('ENV', defaultValue: 'development') == 'production'
        ? Environment.production
        : const String.fromEnvironment('ENV', defaultValue: 'development') == 'staging'
            ? Environment.staging
            : Environment.development;
  }

  static bool get isDevelopment => current == Environment.development;
  static bool get isStaging => current == Environment.staging;
  static bool get isProduction => current == Environment.production;

  static String get appName {
    switch (current) {
      case Environment.development:
        return 'Taning Dev';
      case Environment.staging:
        return 'Taning Staging';
      case Environment.production:
        return 'Taning';
    }
  }

  static String get appSuffix {
    switch (current) {
      case Environment.development:
        return '.dev';
      case Environment.staging:
        return '.staging';
      case Environment.production:
        return '';
    }
  }

  static String get bundleId {
    switch (current) {
      case Environment.development:
        return 'com.taning.app.dev';
      case Environment.staging:
        return 'com.taning.app.staging';
      case Environment.production:
        return 'com.taning.app';
    }
  }

  static String get apiUrl {
    switch (current) {
      case Environment.development:
        return 'https://dev-api.taning.app';
      case Environment.staging:
        return 'https://staging-api.taning.app';
      case Environment.production:
        return 'https://api.taning.app';
    }
  }

  static bool get enableAnalytics {
    return current == Environment.production;
  }

  static bool get enableCrashReporting {
    return current == Environment.production;
  }
}