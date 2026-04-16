class Config {
  static const baseUrl = String.fromEnvironment(
    'API_URL',
    defaultValue: 'https://college-app-316955810695.us-east1.run.app',
  );
}
