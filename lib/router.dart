import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sponsorify/main_layout.dart';
import 'package:sponsorify/page/event/add_event.dart';
import 'package:sponsorify/page/event/dashboard_event.dart';
import 'package:sponsorify/page/event/detail_sponsorship.dart';
import 'package:sponsorify/page/event/saved_event.dart';
import 'package:sponsorify/page/event/search_event.dart';
import 'package:sponsorify/page/login.dart';
import 'package:sponsorify/page/register.dart';
import 'package:sponsorify/page/sponsorship/dashboard_sponsorship.dart';

class Routers extends StatefulWidget {
  const Routers({
    super.key,
  });

  @override
  State<Routers> createState() => _RoutersState();
}

class _RoutersState extends State<Routers> {
  String? tokenLogin;
  bool? isLogin;

  Future<bool> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      tokenLogin = prefs.getString('token');
    });
    if (tokenLogin == null) {
      return false;
    } else {
      return true;
    }
  }

  Future cekLogin() async {
    await getToken().then((value) {
      setState(() {
        isLogin = value;
      });
    });

    print(isLogin);
  }

  @override
  void initState() {
    cekLogin();
    super.initState();
    print(isLogin);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: isLogin! ? '/main_layout' : '/login',
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
        '/add_event': (context) => const AddEvent(),
        '/saved_event': (context) => const SavedEvent(),
        // Sponsorship
        '/dashboard_sponsorship': (context) => const DashboardSponsorship()
      },
    );
  }
}
