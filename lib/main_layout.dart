import 'package:flutter/material.dart';
import 'package:sponsorify/page/event/add_event.dart';
import 'package:sponsorify/page/event/dashboard_event.dart';
import 'package:sponsorify/page/event/saved_event.dart';
import 'package:sponsorify/page/event/search_event.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
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
        destinations: <Widget>[
          const NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          const NavigationDestination(
            selectedIcon: Icon(Icons.saved_search_outlined),
            icon: Icon(Icons.search_outlined),
            label: 'Search',
          ),
          NavigationDestination(
            selectedIcon: Container(
                width: 52,
                decoration: const BoxDecoration(
                    color: Color(0xff372E1D),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                )),
            icon: Container(
                width: 52,
                decoration: const BoxDecoration(
                    color: Color(0xff372E1D),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                )),
            label: 'Add',
          ),
          const NavigationDestination(
            selectedIcon: Icon(Icons.bookmark),
            icon: Icon(Icons.bookmark_outline),
            label: 'Saved',
          ),
          const NavigationDestination(
            selectedIcon: Icon(Icons.person),
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
      body: <Widget>[
        const DashboardEvent(),
        const SearchEvent(),
        const AddEvent(),
        const SavedEvent()
      ][currentPageIndex],
    );
  }
}
