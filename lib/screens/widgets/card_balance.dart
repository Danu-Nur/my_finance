import 'package:flutter/material.dart';
import 'package:my_finance/utils/color.dart';

class CardBalance extends StatelessWidget {
  final List<Widget> children; // Dinamis: bisa menerima list widget
  final Color? backgroundColor; // Warna opsional

  const CardBalance({
    super.key,
    required this.children, // Harus diisi
    this.backgroundColor, // Warna opsional
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: backgroundColor ?? secondaryColor, // Warna default
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children, // Render semua widget yang dikirim
          ),
        ),
      ],
    );
  }
}
