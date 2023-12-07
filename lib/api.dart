abstract class Constants {
  static const String supabaseUrl = String.fromEnvironment(
    'https://kbhfwdxktibqslpkqpkj.supabase.co',
    defaultValue: '',
  );

  static const String supabaseAnnonKey = String.fromEnvironment(
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImtiaGZ3ZHhrdGlicXNscGtxcGtqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDE2MDU5MzEsImV4cCI6MjAxNzE4MTkzMX0.Ji89I1qlefTHNClFZ7JxVKLap9CJQgo0aIlPybQ09Ds',
    defaultValue: '',
  );
}