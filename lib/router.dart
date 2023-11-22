import 'package:flutter/material.dart';
import 'package:sponsorify/main_layout.dart';
import 'package:sponsorify/page/event/dashboard_event.dart';
import 'package:sponsorify/page/event/detail_sponsorship.dart';
import 'package:sponsorify/page/event/search_event.dart';
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
      initialRoute: '/main_layout',
      routes: {
        // Auth
        '/register': (context) => const Register(),
        '/login': (context) => const Login(),
        // Main Layout
        '/main_layout': (context) => const MainLayout(),
        // Event Organizer
        '/dashboard_event': (context) => const DashboardEvent(),
        '/detail_sponsorship': (context) => const DetailSponsorship(),
        '/search_event': (context) => const SearchEvent(),
        // Sponsorship
        '/dashboard_sponsorship': (context) => const DashboardSponsorship()
      },
    );
  }
}
