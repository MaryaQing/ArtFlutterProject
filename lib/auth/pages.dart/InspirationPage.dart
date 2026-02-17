import 'package:flutter/material.dart';

class Inspirationpage extends StatelessWidget {
  const Inspirationpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF372414), // نفس لون الخلفية
      appBar: AppBar(title: const Text("Inspiration")), // مؤقتاً عشان تتأكد إنها اشتغلت
      body: const Center(
        child: Text("Soon...", style: TextStyle(color: Colors.white)),
      ),
    );
  }
}