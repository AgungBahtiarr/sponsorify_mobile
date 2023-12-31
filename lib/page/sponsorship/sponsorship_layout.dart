import 'package:flutter/material.dart';
import 'package:sponsorify/page/sponsorship/dashboard_sponsorship.dart';
import 'package:sponsorify/page/sponsorship/profile_sponsorship.dart';
import 'package:sponsorify/page/sponsorship/proposal_sponsorship.dart';

class SponsorshipLayout extends StatefulWidget {
  const SponsorshipLayout({super.key});

  @override
  State<SponsorshipLayout> createState() => _SponsorshipLayoutState();
}

class _SponsorshipLayoutState extends State<SponsorshipLayout> {
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        // indicatorColor: Colors.amber,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.assignment_returned),
            icon: Icon(Icons.assignment_returned_outlined),
            label: 'Proposal',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.person),
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
      body: <Widget>[
        const DashboardSponsorship(),
        const ProposalSponsorship(),
        const ProfileSponsorship()
      ][currentPageIndex],
    );
  }
}
