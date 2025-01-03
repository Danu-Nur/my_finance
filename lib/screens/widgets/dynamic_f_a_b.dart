import 'package:flutter/material.dart';

class DynamicFAB extends StatelessWidget {
  final Widget addDataPage; // Halaman "add data" yang dituju
  final Color fabColor; // Warna FAB dinamis

  const DynamicFAB({
    super.key,
    required this.addDataPage,
    required this.fabColor,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        // Navigasi ke halaman "add data"
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => addDataPage),
        );
      },
      backgroundColor: fabColor, // Warna FAB
      child: const Icon(Icons.add, color: Colors.white), // Ikon FAB
    );
  }
}
