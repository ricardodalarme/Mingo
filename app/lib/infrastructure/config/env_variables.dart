abstract interface class EnvVariables() {
  static const bool debugSignIn = bool.fromEnvironment('DEBUG_SIGN_IN');
  static const String serverUrl = String.fromEnvironment('SERVER_URL');
  static const String authUrl = String.fromEnvironment('AUTH_URL');
  static const String storageUrl = String.fromEnvironment('STORAGE_URL');
  static const String functionsUrl = String.fromEnvironment('FUNCTIONS_URL');
  static const String revenueCatIosApiKey = String.fromEnvironment('REVENUECAT_IOS_API_KEY');
  static const String revenueCatAndroidApiKey = String.fromEnvironment(
    'REVENUECAT_ANDROID_API_KEY',
  );
}
