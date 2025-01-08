import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
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

  Future<Map<String, List<TransactionModel>>>
      groupTransactionsByMonthYear() async {
    // Fetch transactions from the repository
    final transactions = await Repository().getTransaction();

    Map<String, List<TransactionModel>> groupedData = {};

    for (var transaction in transactions) {
      // Extract month and year from `dateTransfer`
      DateTime parsedDate =
          DateFormat('d MMMM yyyy').parse(transaction.dateTransfer);
      String monthYear = DateFormat('MMMM yyyy')
          .format(parsedDate); // Display month as text (e.g., January 2025)

      // Add transaction to the group
      if (!groupedData.containsKey(monthYear)) {
        groupedData[monthYear] = [];
      }
      groupedData[monthYear]!.add(transaction);
    }

    // Sort keys in descending order by their `DateTime` equivalent
    final sortedKeys = groupedData.keys.toList()
      ..sort((a, b) {
        final dateA = DateFormat('MMMM yyyy').parse(a);
        final dateB = DateFormat('MMMM yyyy').parse(b);
        return dateB.compareTo(dateA); // Descending order
      });

    // Create a new map with sorted keys
    Map<String, List<TransactionModel>> sortedGroupedData = {
      for (var key in sortedKeys) key: groupedData[key]!,
    };

    return sortedGroupedData;
  }

  Future<Map<String, Map<String, List<TransactionModel>>>>
      getGroupTransactionsByYearAndMonth() async {
    // Inisialisasi locale untuk bahasa Indonesia
    await initializeDateFormatting('id_ID', null);

    // Fetch transactions from the repository
    final transactions = await Repository().getTransaction();

    // Map untuk menyimpan data transaksi berdasarkan tahun dan bulan
    Map<String, Map<String, List<TransactionModel>>> groupedData = {};

    for (var transaction in transactions) {
      try {
        // Parsing tanggal dari dateTransfer (dalam format d MMMM yyyy)
        DateTime parsedDate =
            DateFormat('d MMMM yyyy').parse(transaction.dateTransfer);

        // Mendapatkan tahun dan bulan dari tanggal yang diparsing
        String year = parsedDate.year.toString(); // Tahun
        String month =
            DateFormat('MMMM').format(parsedDate); // Nama bulan

        // Inisialisasi jika belum ada grup untuk tahun dan bulan
        groupedData.putIfAbsent(year, () => {});
        groupedData[year]!.putIfAbsent(month, () => []);

        // Menambahkan transaksi ke grup
        groupedData[year]![month]!.add(transaction);
      } catch (e) {
        print('Error parsing date: ${transaction.dateTransfer}, Error: $e');
      }
    }

    // Mengurutkan tahun secara menurun
    final sortedYearKeys = groupedData.keys.toList()
      ..sort((a, b) => int.parse(b).compareTo(int.parse(a)));

    // Mengurutkan bulan secara menurun (dalam setiap tahun)
    Map<String, Map<String, List<TransactionModel>>> sortedGroupedData = {};
    for (var year in sortedYearKeys) {
      final monthKeys = groupedData[year]!.keys.toList()
        ..sort((a, b) {
          final monthA = DateFormat('MMMM').parse(a);
          final monthB = DateFormat('MMMM').parse(b);
          return monthB.month
              .compareTo(monthA.month); // Descending by month number
        });

      sortedGroupedData[year] = {
        for (var month in monthKeys) month: groupedData[year]![month]!,
      };
    }

    return sortedGroupedData;
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
