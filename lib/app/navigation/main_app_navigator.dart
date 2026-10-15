import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:fundsy/features/home/presentation/pages/home_screen.dart';
import 'package:fundsy/features/accounts/presentation/pages/accounts_screen.dart';
import 'package:fundsy/features/categories/presentation/pages/categories_screen.dart';
import 'package:fundsy/features/transactions/presentation/pages/transactions_screen.dart';
import 'package:fundsy/features/insights/presentation/pages/insights_screen.dart';

class MainAppNavigator extends StatefulWidget {
  const MainAppNavigator({super.key});

  @override
  State<MainAppNavigator> createState() {
    return _MainAppNavigatorState();
  }
}

class _MainAppNavigatorState extends State<MainAppNavigator> {
  int _currentIndex = 0;

  final List<String> _titles = const [
    'Home',
    'Accounts',
    'Categories',
    'Transactions',
    'Insights',
  ];

  final List<Widget> _screens = const [
    HomeScreen(),
    AccountsScreen(),
    CategoriesScreen(),
    TransactionsScreen(),
    InsightsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => {},
          icon: Icon(Symbols.menu_rounded),
        ),
        title: Text(_titles[_currentIndex]),
        actions: [
          IconButton(
            onPressed: () => {},
            icon: Icon(Symbols.notifications_none_rounded),
          ),
          IconButton(
            onPressed: () => {},
            icon: Icon(Symbols.search_rounded),
          ),
        ],
      ),
      body: _screens[_currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        child: Icon(Symbols.add_rounded),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) => {
          setState(() => _currentIndex = index)
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Symbols.home_rounded),
            selectedIcon: Icon(
              Symbols.home_rounded,
              fill: 1.0,
            ),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Symbols.money_bag_rounded),
            selectedIcon: Icon(
              Symbols.money_bag_rounded,
              fill: 1.0,
            ),
            label: 'Accounts',
          ),
          NavigationDestination(
            icon: Icon(Symbols.layers_rounded),
            selectedIcon: Icon(
              Symbols.layers_rounded,
              fill: 1.0,
            ),
            label: 'Categories',
          ),
          NavigationDestination(
            icon: Icon(Symbols.payments_rounded),
            selectedIcon: Icon(
              Symbols.payments_rounded,
              fill: 1.0,
            ),
            label: 'Transactions',
          ),
          NavigationDestination(
            icon: Icon(Symbols.bar_chart_rounded),
            selectedIcon: Icon(
              Symbols.bar_chart_rounded,
              fill: 1.0,
            ),
            label: 'Insights',
          ),
        ],
      ),
    );
  }
}
