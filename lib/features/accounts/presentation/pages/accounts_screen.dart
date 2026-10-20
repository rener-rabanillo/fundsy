import 'package:flutter/material.dart';
import '../widgets/account_card.dart';
import 'add_edit_account_screen.dart';
/// AccountsScreen displays financial accounts categorized into On-Budget and Off-Budget,
/// utilizing the reusable AccountCard widget and an interactive modal sheet for new accounts.
class AccountsScreen extends StatelessWidget {
  const AccountsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
          children: [
            // Top "Add account" action button
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                onPressed: () {
                  _showAddAccountBottomSheet(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF1A0B8C),
                  elevation: 2,
                  shadowColor: const Color(0xFF1A0B8C).withValues(alpha: 0.1),
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.0),
                    side: BorderSide(color: Colors.grey.shade200, width: 1.2),
                  ),
                ),
                icon: const Icon(Icons.add_rounded, size: 20),
                label: const Text(
                  'Add account',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.2,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // ON-BUDGET Section Header
            _buildSectionHeader('ON-BUDGET'),
            const SizedBox(height: 14),

            // Wallet Account Card
            const AccountCard(
              title: 'Wallet',
              subtitle: 'Cash',
              balanceLabel: 'Current Balance',
              balanceValue: '₱1,250.00',
            ),
            const SizedBox(height: 12),

            // GCash Account Card
            const AccountCard(
              title: 'GCash',
              subtitle: 'E-Wallet',
              balanceLabel: 'Current Balance',
              balanceValue: '₱9,436.17',
            ),
            const SizedBox(height: 12),

            // Landbank Account Card
            const AccountCard(
              title: 'Landbank',
              subtitle: 'Debit Card · 0.05% p.a.',
              balanceLabel: 'Current Balance',
              balanceValue: '₱103,275.30',
            ),
            const SizedBox(height: 12),

            // BDO Credit Card Account Card
            _buildCreditAccountCard(
              title: 'BDO',
              subtitle: 'Credit Card',
              balanceLabel: 'Outstanding Balance',
              balanceValue: '₱1,395.00',
              progressValue: 0.1395,
              progressText: '13.95% used',
              availableCreditText: '₱8,605.00 available credit',
            ),
            const SizedBox(height: 28),

            // OFF-BUDGET Section Header
            _buildSectionHeader('OFF-BUDGET'),
            const SizedBox(height: 14),

            // Retirement Fund Account Card
            const AccountCard(
              title: 'Retirement Fund',
              subtitle: 'Asset',
              balanceLabel: 'Current Balance',
              balanceValue: '₱1,925,250.00',
            ),
          ],
        ),
      ),
    );
  }

  /// Displays the modal bottom sheet for creating a new account.
  void _showAddAccountBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(32.0)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateModal) {
            bool doNotIncludeOnBudget = false;

            return Padding(
              padding: EdgeInsets.only(
                left: 20.0,
                right: 20.0,
                top: 12.0,
                bottom: MediaQuery.of(context).viewInsets.bottom + 32.0,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Drag Indicator Handle
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(2.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Modal Header Title
                  const Center(
                    child: Text(
                      'New Account',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Choose Account Type Section Header
                  Text(
                    'Choose Account Type',
                    style: TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade500,
                      letterSpacing: 0.8,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // 1. Cash Option -> Bubukas ang AddEditAccountScreen para sa Cash
                  AccountCard(
                    iconData: Icons.payments_outlined,
                    title: 'Cash',
                    onTap: () {
                      Navigator.pop(context); // Isara ang modal
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddEditAccountScreen(accountType: 'Cash'),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 10),

                  // 2. E-Wallet Option -> Bubukas ang AddEditAccountScreen para sa E-Wallet
                  AccountCard(
                    iconData: Icons.account_balance_wallet_outlined,
                    title: 'E-Wallet',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddEditAccountScreen(accountType: 'E-Wallet'),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 10),

                  // 3. Debit Card Option -> Bubukas ang AddEditAccountScreen para sa Debit Card[cite: 10]
                  AccountCard(
                    iconData: Icons.credit_card_outlined,
                    title: 'Debit Card',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddEditAccountScreen(accountType: 'Debit Card'),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 10),

                  // 4. Credit Card Option -> Bubukas ang AddEditAccountScreen para sa Credit Card
                  AccountCard(
                    iconData: Icons.credit_card_outlined,
                    title: 'Credit Card',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddEditAccountScreen(accountType: 'Credit Card'),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),

                  // Do not include on budget Toggle Container
                  AccountCard(
                    title: 'Do not include on budget',
                    onTap: () {
                      setStateModal(() {
                        doNotIncludeOnBudget = !doNotIncludeOnBudget;
                      });
                    },
                    trailing: Switch(
                      value: doNotIncludeOnBudget,
                      activeTrackColor: const Color(0xFF1A0B8C),
                      activeThumbColor: Colors.white,
                      inactiveThumbColor: Colors.grey.shade400,
                      inactiveTrackColor: Colors.grey.shade200,
                      onChanged: (val) {
                        setStateModal(() {
                          doNotIncludeOnBudget = val;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 28),

                  // Modal Action Buttons (Cancel)
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFF1A0B8C),
                            side: const BorderSide(color: Color(0xFF1A0B8C), width: 1.5),
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                          ),
                          child: const Text(
                            'Cancel',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  /// Builds standardized section header labels (e.g., ON-BUDGET, OFF-BUDGET).
  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w900,
        letterSpacing: 1.2,
        color: Color(0xFF64748B),
      ),
    );
  }

  /// Builds specialized credit card accounts featuring an enhanced credit usage progress bar indicator.
  Widget _buildCreditAccountCard({
    required String title,
    required String subtitle,
    required String balanceLabel,
    required String balanceValue,
    required double progressValue,
    required String progressText,
    required String availableCreditText,
  }) {
    return Container(
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: Colors.grey.shade100, width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 2.0),
                child: Icon(
                  Icons.credit_card_outlined,
                  size: 26.0,
                  color: Color(0xFF0F172A),
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 15.5,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F172A),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2.0),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    balanceLabel,
                    style: TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade400,
                    ),
                  ),
                  const SizedBox(height: 2.0),
                  Text(
                    balanceValue,
                    style: const TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 18),
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: LinearProgressIndicator(
              value: progressValue,
              minHeight: 8,
              backgroundColor: Colors.grey.shade100,
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF1A0B8C)),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                progressText,
                style: TextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade500,
                ),
              ),
              Text(
                availableCreditText,
                style: TextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}