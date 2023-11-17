import 'package:flutter/material.dart';
import 'package:sponsorify/page/event/dashboard_event.dart';
import 'package:sponsorify/page/event/detail_sponsorship.dart';
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
      initialRoute: '/detail_sponsorship',
      routes: {
        // Auth
        '/register': (context) => const Register(),
        '/login': (context) => const Login(),
        // Event Organizer
        '/dashboard_event': (context) => const DashboardEvent(),
        '/detail_sponsorship':(context) => const DetailSponsorship(),
        // Sponsorship
        '/dashboard_sponsorship': (context) => const DashboardSponsorship()
      },
    );
  }
}
