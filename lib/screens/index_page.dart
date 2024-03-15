import 'package:flutter/material.dart';
import 'package:room_rental/screens/dashboard.dart';
import 'package:room_rental/screens/payments.dart';
import 'package:room_rental/screens/services_page.dart';
import 'package:room_rental/screens/settings.dart';
import 'package:room_rental/utils/constants/branding_colors.dart';

class IndexingPage extends StatefulWidget {
  final int? selectedIndex;

  const IndexingPage({
    super.key,
    this.selectedIndex,
  });

  @override
  State<IndexingPage> createState() => _IndexingPageState();
}

class _IndexingPageState extends State<IndexingPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _widgetOptions = <Widget>[];

  @override
  void initState() {
    super.initState();

    _widgetOptions.addAll([
      const Dashboard(),
      const PaymentsPage(),
      const ServicesPage(),
      const SettingsPage(),
    ]);

    if (widget.selectedIndex != null) {
      setState(() {
        _selectedIndex = widget.selectedIndex!;
      });
    } else {
      setState(() {
        _selectedIndex = 0;
      });
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        selectedFontSize: 12.0,
        unselectedFontSize: 10.0,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        backgroundColor: BrandingColors.bottomAppbarColor,
        fixedColor: BrandingColors.subtitleColor,
        unselectedItemColor: BrandingColors.subtitleColor,
        items: [
          bottomNavigationBarItem(context, "Home", Icons.home_filled),
          bottomNavigationBarItem(context, "Payments", Icons.payments_rounded),
          bottomNavigationBarItem(
              context, "Service", Icons.construction_rounded),
          bottomNavigationBarItem(context, "Settings", Icons.build_rounded),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  BottomNavigationBarItem bottomNavigationBarItem(
      BuildContext context, String label, IconData iconName) {
    return BottomNavigationBarItem(
      tooltip: label,
      label: label,
      activeIcon: Icon(
        iconName,
        color: BrandingColors.primaryColor,
        size: 30,
      ),
      icon: Icon(
        iconName,
        color: Colors.grey,
      ),
    );
  }
}
