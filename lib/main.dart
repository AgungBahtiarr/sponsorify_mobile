import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sponsorify/router.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  runApp(const Sponsorify());
}

class Sponsorify extends StatelessWidget {
  const Sponsorify({super.key});

  @override
  Widget build(BuildContext context) {
    return const Routers();
  }
}
