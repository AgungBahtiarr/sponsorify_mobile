import 'package:flutter/material.dart';
import 'package:sponsorify/routers.dart';

void main() {
  runApp(const Sponsorify());
}

class Sponsorify extends StatelessWidget {
  const Sponsorify({super.key});

  @override
  Widget build(BuildContext context) {
    return const Routers();
  }
}
