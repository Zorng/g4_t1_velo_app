import 'package:flutter/material.dart';
import 'package:g4_t1_velo_app/model/bicycle.dart';
import 'package:g4_t1_velo_app/model/bike_slot.dart';
import 'package:g4_t1_velo_app/model/location.dart';
import 'package:g4_t1_velo_app/model/station.dart';
import 'package:g4_t1_velo_app/ui/screens/account/account_screen.dart';
import 'package:g4_t1_velo_app/ui/screens/booking/booking.dart';
import 'package:g4_t1_velo_app/ui/screens/journey/journey_screen.dart';
import 'package:g4_t1_velo_app/ui/screens/map/map_screen.dart';
import 'package:g4_t1_velo_app/ui/screens/subscriptions/subscriptions_screen.dart';
import 'package:g4_t1_velo_app/ui/theme/theme.dart';
import 'package:provider/provider.dart';

///
/// Launch the application with the given list of providers
///
void mainCommon(List<InheritedProvider> providers) {
  final child = MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Booking(
      slot: BikeSlot(
        id: 'D-04',
        station: Station(
          id: 's1',
          name: 'Veal Vong Park',
          location: Location(
            id: 'l1',
            longitude: 104.9282,
            latitude: 11.5564,
            address: 'Veal Vong Park, Phnom Penh',
          ),
          totalSlot: 10,
          slots: [],
        ),
        bike: Bicycle(id: 'b1', bikeNo: 'BK-2047'),
      ),
    ),
  );
  runApp(
    providers.isEmpty
        ? child
        : MultiProvider(providers: providers, child: child),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 2; // map screen as default entry

  final List<Widget> _pages = [
    AccountScreen(),
    JourneyScreen(),
    MapScreen(),
    SubscriptionsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: Scaffold(
        backgroundColor: appTheme.scaffoldBackgroundColor,
        body: _pages[_currentIndex],

        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          selectedItemColor: appTheme.primaryColor,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_rounded),
              label: 'Account',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.directions_bike),
              label: 'Journey',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Map'),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_play),
              label: 'Subscriptions',
            ),
          ],
        ),
      ),
    );
  }
}
