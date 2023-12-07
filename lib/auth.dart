import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRepository {
  Future<String> signInEmailAndPassword(String email, String password);
  Future<String> signUpEmailAndPassword(String email, String password);
  Future resetPassword(String email);

  Future<void> signOut();
}


class SupabaseAuthRepository implements AuthRepository {
  final Supabase _supabase = Supabase.instance;

  @override
  Future<String> signInEmailAndPassword(String email, String password) async {
    try {
      final response = await _supabase.client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      final userId = response.user?.id;
      if (userId == null) {
        return "0";
      }
    }on AuthException{
      return "0";
    }
    return "1";
  }

  @override
  Future resetPassword(String email) async {
    await _supabase.client.auth.resetPasswordForEmail(email);
  }

  @override
  Future<String> signUpEmailAndPassword(String email, String password) async {
    await _supabase.client.auth.signUp(email: email, password: password);
    return "1";
  }

  @override
  Future<void> signOut() async {
    await _supabase.client.auth.signOut();
    return;
  }
}
