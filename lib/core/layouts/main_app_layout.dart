import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class MainAppLayout extends StatefulWidget {
  final String title;
  final Widget child;
  final bool showFloatingActionButton;
  final bool showNavigationBar;

  const MainAppLayout({
    required this.title,
    required this.child,
    this.showFloatingActionButton = true,
    this.showNavigationBar = true,
    super.key
  });

  @override
  State<MainAppLayout> createState() {
    return _MainAppLayoutState();
  }
}

class _MainAppLayoutState extends State<MainAppLayout> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => {},
          icon: Icon(Symbols.menu_rounded),
        ),
        title: Text(widget.title),
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
      body: widget.child,
      floatingActionButton: widget.showFloatingActionButton
        ? FloatingActionButton(
            onPressed: () => {},
            child: Icon(Symbols.add_rounded),
          )
        : null,
      bottomNavigationBar: widget.showNavigationBar
        ? Theme(
            data: Theme.of(context).copyWith(
              splashFactory: NoSplash.splashFactory,
            ),
            child: BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: (index) => {
                setState(() => _currentIndex = index)
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Symbols.dashboard_rounded),
                  activeIcon: Icon(
                    Symbols.dashboard_rounded,
                    fill: 1.0,
                  ),
                  label: 'Dashboard',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Symbols.wallet_rounded),
                  activeIcon: Icon(
                    Symbols.wallet_rounded,
                    fill: 1.0,
                  ),
                  label: 'Accounts',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Symbols.savings_rounded),
                  activeIcon: Icon(
                    Symbols.savings_rounded,
                    fill: 1.0,
                  ),
                  label: 'Categories',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Symbols.swap_horiz_rounded),
                  activeIcon: Icon(
                    Symbols.swap_horiz_rounded,
                    fill: 1.0,
                  ),
                  label: 'Transactions',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Symbols.bar_chart_rounded),
                  activeIcon: Icon(
                    Symbols.bar_chart_rounded,
                    fill: 1.0,
                  ),
                  label: 'Insights',
                ),
              ],
            ),
          )
        : null,
    );
  }
}
