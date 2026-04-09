class Config {
  static const baseUrl = String.fromEnvironment(
    'API_URL',
    defaultValue: 'https://api.matemcollege.com/api/v1',
  );
}
