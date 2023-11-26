import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardSponsorship extends StatefulWidget {
  const DashboardSponsorship({super.key});

  @override
  State<DashboardSponsorship> createState() => _DashboardSponsorshipState();
}

class _DashboardSponsorshipState extends State<DashboardSponsorship> {
  String? token;
  getPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      token = prefs.getString('token');
    });
  }

  @override
  void initState() {
    getPref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
