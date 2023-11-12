import 'package:flutter/material.dart';
import 'package:sponsorify/page/dashboard_event.dart';
import 'package:sponsorify/page/login.dart';
import 'package:sponsorify/page/register.dart';

class Routers extends StatelessWidget {
  const Routers({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/register',
      routes: {
        '/register': (context) => const Register(),
        '/login': (context) => const Login(),
        '/dashboard': (context) => const DashboardEvent()
      },
    );
  }
}
