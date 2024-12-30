import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:my_finance/data/model/credit_card_model.dart';
import 'package:my_finance/data/model/pocket_model.dart';
import 'package:my_finance/data/model/saving_target_model.dart';
import 'package:my_finance/data/model/transaction_model.dart';

class Repository {
  // Generic method to fetch and parse JSON data
  Future<List<T>> _fetchData<T>(
      String path, T Function(Map<String, dynamic>) fromJson) async {
    final jsonString = await rootBundle.loadString(path);
    final List<dynamic> jsonData = jsonDecode(jsonString);

    return jsonData
        .map((item) => fromJson(item as Map<String, dynamic>))
        .toList();
  }

  // Methods to retrieve specific data
  Future<List<SavingTargetModel>> getSavingTarget() async {
    return _fetchData<SavingTargetModel>(
      'lib/assets/json/saving_target_dummy.json',
      (json) => SavingTargetModel.fromJson(json),
    );
  }

  Future<List<TransactionModel>> getTransaction() async {
    return _fetchData<TransactionModel>(
      'lib/assets/json/transaction_dummy.json',
      (json) => TransactionModel.fromJson(json),
    );
  }

  Future<List<CreditCardModel>> getCreditCard() async {
    return _fetchData<CreditCardModel>(
      'lib/assets/json/credit_card_dummy.json',
      (json) => CreditCardModel.fromJson(json),
    );
  }

  Future<List<PocketModel>> getPocket() async {
    return _fetchData<PocketModel>(
      'lib/assets/json/pocket_dummy.json',
      (json) => PocketModel.fromJson(json),
    );
  }
}
