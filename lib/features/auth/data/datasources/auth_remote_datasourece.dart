import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRemoteDataSource {
  Future<void> signIn({required String email, required String password});

  Future<void> signUp({required String email, required String password, required String fullName});

  Future<void> signOut();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient client;

  AuthRemoteDataSourceImpl(this.client);

  @override
  Future<void> signIn({required String email, required String password}) async {
    if (kDebugMode) {
      debugPrint('Trying sign in with email: $email');
    }

    final response = await client.auth.signInWithPassword(email: email, password: password);

    if (response.user == null) {
      throw const AuthException('Invalid login credentials');
    }

    if (kDebugMode) {
      debugPrint('Signed in user id: ${response.user!.id}');
    }
  }

  @override
  Future<void> signUp({
    required String email,
    required String password,
    required String fullName,
  }) async {
    if (kDebugMode) {
      debugPrint('Trying sign up with email: $email');
    }

    final response = await client.auth.signUp(
      email: email,
      password: password,
      data: {'full_name': fullName},
    );

    if (response.user == null) {
      throw const AuthException('Sign up failed');
    }

    if (kDebugMode) {
      debugPrint('Signed up user id: ${response.user!.id}');
    }
  }

  @override
  Future<void> signOut() async {
    await client.auth.signOut();

    if (kDebugMode) {
      debugPrint('Signed out successfully');
    }
  }
}
