import 'package:flutter/material.dart';
import 'package:sponsorify/page/event/dashboard_event.dart';
import 'package:sponsorify/page/login.dart';
import 'package:sponsorify/page/register.dart';
import 'package:sponsorify/page/sponsorship/dashboard_sponsorship.dart';

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
        '/dashboard_event': (context) => const DashboardEvent(),
        '/dashboard_sponsorship': (context) => const DashboardSponsorship()
      },
    );
  }
}
