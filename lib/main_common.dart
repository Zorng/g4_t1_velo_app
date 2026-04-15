import 'package:flutter/material.dart';
import 'package:g4_t1_velo_app/ui/screens/account/account_screen.dart';
import 'package:g4_t1_velo_app/ui/screens/journey/journey_screen.dart';
import 'package:g4_t1_velo_app/ui/screens/map/map_screen.dart';
import 'package:g4_t1_velo_app/ui/screens/subscriptions/subscriptions_screen.dart';
import 'package:g4_t1_velo_app/ui/theme/theme.dart';
import 'package:provider/provider.dart';


///
/// Launch the application with the given list of providers
///
void mainCommon(List<InheritedProvider> providers) {
  runApp(
    MultiProvider(
      providers: providers,
      child: MaterialApp(debugShowCheckedModeBanner: false, home: MyApp()),
    ),
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
   SubscriptionsScreen()
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
          currentIndex: _currentIndex,
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
            BottomNavigationBarItem(icon: Icon(Icons.directions_bike), label: 'Journey'),
            BottomNavigationBarItem(
              icon: Icon(Icons.map),
              label: 'Map',
            ),
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
