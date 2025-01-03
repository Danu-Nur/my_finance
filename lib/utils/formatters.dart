import 'package:intl/intl.dart';

// Formatter untuk Rupiah
final rupiahFormatter = NumberFormat.currency(
  locale: 'id_ID', // Locale Indonesia
  symbol: 'Rp ',    // Simbol Rupiah
  decimalDigits: 0, // Jumlah angka di belakang koma
);
