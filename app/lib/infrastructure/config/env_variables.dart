abstract interface class EnvVariables() {
  static const bool debugSignIn = .fromEnvironment('DEBUG_SIGN_IN');
  static const String termsUrl = .fromEnvironment('TERMS_URL');
  static const String privacyUrl = .fromEnvironment('PRIVACY_URL');
  static const String serverUrl = .fromEnvironment('SERVER_URL');
  static const String authUrl = .fromEnvironment('AUTH_URL');
  static const String storageUrl = .fromEnvironment('STORAGE_URL');
  static const String functionsUrl = .fromEnvironment('FUNCTIONS_URL');
  static const String revenueCatIosApiKey = .fromEnvironment('REVENUECAT_IOS_API_KEY');
  static const String revenueCatAndroidApiKey = .fromEnvironment('REVENUECAT_ANDROID_API_KEY');
}
