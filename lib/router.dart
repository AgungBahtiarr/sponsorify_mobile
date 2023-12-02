import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sponsorify/page/event/event_layout.dart';
import 'package:sponsorify/page/event/add_event.dart';
import 'package:sponsorify/page/event/dashboard_event.dart';
import 'package:sponsorify/page/event/detail_sponsorship.dart';
import 'package:sponsorify/page/event/edit_profile_event.dart';
import 'package:sponsorify/page/event/myevent.dart';
import 'package:sponsorify/page/event/profile_event.dart';
import 'package:sponsorify/page/event/saved_event.dart';
import 'package:sponsorify/page/event/search_event.dart';
import 'package:sponsorify/page/login.dart';
import 'package:sponsorify/page/register.dart';
import 'package:sponsorify/page/sponsorship/add_sponsorship.dart';
import 'package:sponsorify/page/sponsorship/dashboard_sponsorship.dart';
import 'package:sponsorify/page/sponsorship/detail_event.dart';
import 'package:sponsorify/page/sponsorship/edit_profile_sponsorship.dart';
import 'package:sponsorify/page/sponsorship/my_sponsorship.dart';
import 'package:sponsorify/page/sponsorship/profile_sponsorship.dart';
import 'package:sponsorify/page/sponsorship/proposal_sponsorship.dart';
import 'package:sponsorify/page/sponsorship/sponsorship_layout.dart';

class Routers extends StatefulWidget {
  const Routers({
    super.key,
  });

  @override
  State<Routers> createState() => _RoutersState();
}

class _RoutersState extends State<Routers> {
  String? tokenLogin;
  int? role;
  bool? isLogin;
  String? nextPage;

  bool isLoading = false;

  Future<bool> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      tokenLogin = prefs.getString('token');
      role = prefs.getInt('role');
    });
    if (tokenLogin == null) {
      return false;
    } else {
      return true;
    }
  }

  Future getRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      role = prefs.getInt('role');
    });
    // prefs.clear();
    return role;
  }

  Future cekLogin() async {
    await getToken().then((value) {
      setState(() {
        isLogin = value;
      });
    });

    await getRole().then((value) {
      setState(() {
        role = value;
        if (role == 1) {
          nextPage = '/event_layout';
        } else {
          nextPage = '/sponsorship_layout';
        }
      });
    });
  }

  @override
  void initState() {
    setState(() {
      isLoading = true;
    });
    cekLogin();
    setState(() {
      isLoading = false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: isLogin! ? nextPage! : '/login',
      routes: {
        // Auth
        '/register': (context) => const Register(),
        '/login': (context) => const Login(),
        // Main Layout
        '/event_layout': (context) => const EventLayout(),
        '/sponsorship_layout': (context) => const SponsorshipLayout(),
        // Event Organizer
        '/dashboard_event': (context) => const DashboardEvent(),
        '/detail_sponsorship': (context) => const DetailSponsorship(),
        '/search_event': (context) => const SearchEvent(),
        '/add_event': (context) => const AddEvent(),
        '/saved_event': (context) => const SavedEvent(),
        '/profile_event': (context) => const ProfileEvent(),
        '/myevent': (context) => const MyEvent(),
        '/edit_profile_event': (context) => const EditProfileEvent(),
        // Sponsorship
        '/dashboard_sponsorship': (context) => const DashboardSponsorship(),
        '/add_sponsorship': (context) => const AddSponsorship(),
        '/proposal_sponsorship': (context) => const ProposalSponsorship(),
        '/detail_event': (context) => const DetailEvent(),
        '/profile_sponsorship': (context) => const ProfileSponsorship(),
        '/edit_profile_sponsorship': (context) =>
            const EditProfileSponsorship(),
        '/my_sponsorship': (context) => const MySponsorship()
      },
    );
  }
}
