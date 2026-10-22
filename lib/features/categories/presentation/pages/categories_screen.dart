import 'package:flutter/material.dart';
import 'category_card.dart';

/// CategoriesScreen displays financial categories grouped into tabs:
/// All, Incomes, Expenses, Goals, Payables, and Receivables.
class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  int selectedCategoryTab = 0; // 0: All, 1: Incomes, 2: Expenses, 3: Goals, 4: Payables, 5: Receivables

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12), // Spacing from top

            // 1. Filter Tabs (All, Incomes, Expenses, Goals, Payables, Receivables)
            SizedBox(
              height: 45,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: [
                  _buildFilterTab('All', 0),
                  _buildFilterTab('Incomes', 1),
                  _buildFilterTab('Expenses', 2),
                  _buildFilterTab('Goals', 3),
                  _buildFilterTab('Payables', 4),
                  _buildFilterTab('Receivables', 5),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // 2. Add Category Button (Aligned to the right like the "+ Add account" design)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.03),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.add_rounded, color: Color(0xFF0F172A), size: 20),
                    label: const Text(
                      'Add category',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F172A),
                        fontSize: 13.5,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.grey.shade200, width: 1.2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 3. Main Content List based on Selected Tab
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                children: _buildTabContent(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Helper widget to build individual filter tab buttons
  Widget _buildFilterTab(String title, int index) {
    bool isSelected = selectedCategoryTab == index;
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedCategoryTab = index;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF1A0B8C) : Colors.white,
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(
              color: isSelected ? Colors.transparent : Colors.grey.shade200,
              width: 1.2,
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              fontSize: 13.5,
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.white : Colors.grey.shade700,
            ),
          ),
        ),
      ),
    );
  }

  /// Returns the appropriate list of cards depending on the active tab
  List<Widget> _buildTabContent() {
    List<Widget> content = [];

    // If "All" (0) or "Incomes" (1) is selected
    if (selectedCategoryTab == 0 || selectedCategoryTab == 1) {
      content.addAll([
        _sectionHeader('INCOMES', 'Add and review your earnings'),
        const CategoryCard(
          icon: Icons.arrow_upward_rounded,
          title: 'Company Salary',
          subtitle: 'Recurring Income',
          rightTopLabel: 'Received this month',
          rightBottomLabel: '₱24,000.00',
          themeColor: Colors.green,
        ),
        const CategoryCard(
          icon: Icons.arrow_upward_rounded,
          title: 'Freelance Work',
          subtitle: 'Variable Income',
          rightTopLabel: 'Received this month',
          rightBottomLabel: '₱2,500.00',
          themeColor: Colors.green,
        ),
        const SizedBox(height: 16),
      ]);
    }

    // If "All" (0) or "Expenses" (2) is selected
    if (selectedCategoryTab == 0 || selectedCategoryTab == 2) {
      content.addAll([
        _sectionHeader('EXPENSES', 'Set a budget and track how much you spent'),
        const CategoryCard(
          icon: Icons.arrow_downward_rounded,
          title: 'Electricity',
          subtitle: 'Recurring Expense',
          rightTopLabel: 'Allocated',
          rightBottomLabel: '₱2,500.00',
          themeColor: Colors.red,
          progressValue: 1.0,
          dateText: '₱2,500.00 spent · ₱0.00 available',
        ),
        const CategoryCard(
          icon: Icons.arrow_downward_rounded,
          title: 'Groceries',
          subtitle: 'Variable Expense',
          rightTopLabel: 'Allocated',
          rightBottomLabel: '₱1,000.00',
          themeColor: Colors.red,
          progressValue: 0.475,
          dateText: '₱475.00 spent · ₱525.00 available',
        ),
        const SizedBox(height: 16),
      ]);
    }

    // If "All" (0) or "Goals" (3) is selected
    if (selectedCategoryTab == 0 || selectedCategoryTab == 3) {
      content.addAll([
        _sectionHeader('GOALS', 'Plan and monitor your financial goals'),
        const CategoryCard(
          icon: Icons.track_changes_rounded,
          title: 'New Laptop',
          subtitle: '',
          rightTopLabel: 'Target',
          rightBottomLabel: '₱64,999.00',
          themeColor: Colors.deepPurple,
          progressValue: 0.92,
          dateText: 'June 30, 2026 · 1 month left',
        ),
        const SizedBox(height: 16),
      ]);
    }

    // If "All" (0) or "Payables" (4) is selected
    if (selectedCategoryTab == 0 || selectedCategoryTab == 4) {
      content.addAll([
        _sectionHeader('PAYABLES', 'Record and manage your debt'),
        const CategoryCard(
          icon: Icons.money_off_rounded,
          title: 'Motorcycle Loan',
          subtitle: '',
          rightTopLabel: 'Owed',
          rightBottomLabel: '₱10,000.00',
          themeColor: Colors.amber,
          progressValue: 0.65,
          dateText: 'June 12, 2026 · 2 weeks left',
        ),
        const SizedBox(height: 16),
      ]);
    }

    // If "All" (0) or "Receivables" (5) is selected
    if (selectedCategoryTab == 0 || selectedCategoryTab == 5) {
      content.addAll([
        _sectionHeader('RECEIVABLES', 'Keep a list of all money owed to you'),
        const CategoryCard(
          icon: Icons.account_balance_wallet_rounded,
          title: 'Greg - Dine Out',
          subtitle: '',
          rightTopLabel: 'Receivable',
          rightBottomLabel: '₱250.00',
          themeColor: Colors.purple,
          progressValue: 0.4,
          dateText: '₱100.00 collected · ₱150.00 remaining',
        ),
        const SizedBox(height: 16),
      ]);
    }

    return content;
  }

  /// Helper for section titles
  Widget _sectionHeader(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0, top: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }
}