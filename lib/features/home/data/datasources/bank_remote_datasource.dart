import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/error/exceptions.dart' as app_exceptions;
import '../models/account_model.dart';
import '../models/transaction_model.dart';

abstract class BankRemoteDataSource {
  Future<List<AccountModel>> getAccounts();

  Future<List<TransactionModel>> getTransactions();
}

class BankRemoteDataSourceImpl implements BankRemoteDataSource {
  final SupabaseClient client;

  BankRemoteDataSourceImpl(this.client);

  @override
  Future<List<AccountModel>> getAccounts() async {
    try {
      final userId = client.auth.currentUser?.id;

      if (userId == null) {
        throw const app_exceptions.AuthException();
      }

      final response = await client
          .from('accounts')
          .select('id, owner_name, card_number, balance, bank_name, user_id')
          .eq('user_id', userId);

      if (kDebugMode) {
        debugPrint('Accounts fetched: ${response.length}');
      }

      return response
          .map<AccountModel>((json) => AccountModel.fromJson(Map<String, dynamic>.from(json)))
          .toList();
    } on PostgrestException catch (e) {
      if (kDebugMode) {
        debugPrint('Accounts PostgrestException: ${e.message}');
      }
      throw const app_exceptions.ServerException();
    } on app_exceptions.AuthException {
      rethrow;
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Accounts UnknownException: $e');
      }
      throw const app_exceptions.UnknownException();
    }
  }

  @override
  Future<List<TransactionModel>> getTransactions() async {
    try {
      final userId = client.auth.currentUser?.id;

      if (userId == null) {
        throw const app_exceptions.AuthException();
      }

      final response = await client
          .from('transactions')
          .select('id, title, amount, type, date, icon, user_id')
          .eq('user_id', userId)
          .order('date', ascending: false)
          .limit(20);

      if (kDebugMode) {
        debugPrint('Transactions fetched: ${response.length}');
      }

      return response
          .map<TransactionModel>(
            (json) => TransactionModel.fromJson(Map<String, dynamic>.from(json)),
          )
          .toList();
    } on PostgrestException catch (e) {
      if (kDebugMode) {
        debugPrint('Transactions PostgrestException: ${e.message}');
      }
      throw const app_exceptions.ServerException();
    } on app_exceptions.AuthException {
      rethrow;
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Transactions UnknownException: $e');
      }
      throw const app_exceptions.UnknownException();
    }
  }
}
