import 'package:flutter/material.dart';

class MenuPanel extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const MenuPanel({super.key, required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 280,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: const Color(0xDD1D3557),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ...children,
          ],
        ),
      ),
    );
  }
}