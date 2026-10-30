import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:fundsy/features/home/presentation/pages/home_screen.dart';
import 'package:fundsy/features/accounts/presentation/pages/accounts_screen.dart';
import 'package:fundsy/features/categories/presentation/pages/categories_screen.dart';
import 'package:fundsy/features/transactions/presentation/pages/transactions_screen.dart';
import 'package:fundsy/features/insights/presentation/pages/insights_screen.dart';
import 'package:fundsy/features/transactions/presentation/utils/ocr_helper.dart';
import 'package:fundsy/features/transactions/presentation/utils/voice_helper.dart';
import 'package:fundsy/features/transactions/presentation/widgets/manual_entry_bottom_sheet.dart';

class MainAppNavigator extends StatefulWidget {
  const MainAppNavigator({super.key});

  @override
  State<MainAppNavigator> createState() {
    return _MainAppNavigatorState();
  }
}

class _MainAppNavigatorState extends State<MainAppNavigator> with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  bool _isOpened = false;
  late AnimationController _animationController;
  late Animation<double> _animateIcon;

  final OcrHelper _ocrHelper = OcrHelper();
  final VoiceHelper _voiceHelper = VoiceHelper();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _animateIcon = Tween<double>(begin: 0.0, end: 0.125).animate(_animationController);
  }

  @override
  void dispose() {
    _ocrHelper.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _toggleMenu() {
    setState(() {
      _isOpened = !_isOpened;
      if (_isOpened) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  void _handleCameraScan() async {
    _toggleMenu();
    debugPrint('Starting Camera OCR...');
    String? extractedText = await _ocrHelper.extractTextFromCamera();
    if (extractedText != null && extractedText.isNotEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('OCR Success! Na-scan ang resibo.')),
        );
      }
    }
  }

  void _handleVoiceEntry() {
    _toggleMenu();
    debugPrint('Starting Voice Recognition...');
    _voiceHelper.startListening(
      onResult: (recognizedText) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Voice: "$recognizedText"')),
          );
        }
      },
    );
  }

  void _handleManualEntry() {
    _toggleMenu();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => const ManualEntryBottomSheet(),
    );
  }

  final List<String> _titles = const ['Home', 'Accounts', 'Categories', 'Transactions', 'Insights'];
  final List<Widget> _screens = const [HomePage(), AccountsScreen(), CategoriesScreen(), TransactionsScreen(), InsightsScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Symbols.menu_rounded),
        ),
        title: Text(_titles[_currentIndex]),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Symbols.notifications_none_rounded),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Symbols.search_rounded),
          ),
        ],
      ),
      // Inalis na natin ang dark background/overlay, kaya direkta nang ipinapakita ang screen
      body: _screens[_currentIndex],
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (_isOpened) ...[
            FloatingActionButton.small(
              heroTag: 'voiceBtn',
              backgroundColor: const Color(0xFF1A0B8C),
              foregroundColor: Colors.white,
              elevation: 2,
              splashColor: Colors.transparent,
              highlightElevation: 2,
              onPressed: _handleVoiceEntry,
              child: const Icon(Icons.mic),
            ),
            const SizedBox(height: 12),
          ],
          if (_isOpened) ...[
            FloatingActionButton.small(
              heroTag: 'cameraBtn',
              backgroundColor: const Color(0xFF1A0B8C),
              foregroundColor: Colors.white,
              elevation: 2,
              splashColor: Colors.transparent,
              highlightElevation: 2,
              onPressed: _handleCameraScan,
              child: const Icon(Icons.camera_alt),
            ),
            const SizedBox(height: 12),
          ],
          if (_isOpened) ...[
            FloatingActionButton.small(
              heroTag: 'manualBtn',
              backgroundColor: const Color(0xFF1A0B8C),
              foregroundColor: Colors.white,
              elevation: 2,
              splashColor: Colors.transparent,
              highlightElevation: 2,
              onPressed: _handleManualEntry,
              child: const Icon(Icons.edit),
            ),
            const SizedBox(height: 12),
          ],
          FloatingActionButton(
            backgroundColor: const Color(0xFF1A0B8C),
            foregroundColor: Colors.white,
            splashColor: Colors.transparent,
            highlightElevation: 6,
            onPressed: _toggleMenu,
            child: RotationTransition(
              turns: _animateIcon,
              child: const Icon(Symbols.add_rounded),
            ),
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) => setState(() => _currentIndex = index),
        destinations: const [
          NavigationDestination(icon: Icon(Symbols.home_rounded), label: 'Home'),
          NavigationDestination(icon: Icon(Symbols.money_bag_rounded), label: 'Accounts'),
          NavigationDestination(icon: Icon(Symbols.layers_rounded), label: 'Categories'),
          NavigationDestination(icon: Icon(Symbols.payments_rounded), label: 'Transactions'),
          NavigationDestination(icon: Icon(Symbols.bar_chart_rounded), label: 'Insights'),
        ],
      ),
    );
  }
}