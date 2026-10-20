import 'package:flutter/material.dart';

/// TransactionsScreen represents the history screen of the Fundsy application.
/// Styled precisely with the date on top, bold title below, and category details at the bottom.
class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          children: [
            // TODAY Section Header
            _buildSectionHeader('TODAY'),
            const SizedBox(height: 12),

            // Jollibee Transaction
            _buildTransactionCard(
              date: 'May 26, 2026',
              title: 'Jollibee',
              subtitle: 'GCash · Food',
              amount: '-₱130.00',
              amountColor: Colors.redAccent,
            ),
            const SizedBox(height: 12),

            // Cash Outflow Transaction
            _buildTransactionCard(
              date: 'May 26, 2026',
              title: 'Outflow: from Cash',
              subtitle: 'Cash · Transportation',
              amount: '-₱50.00',
              amountColor: Colors.redAccent,
            ),
            const SizedBox(height: 12),

            // BDO Outflow Transaction
            _buildTransactionCard(
              date: 'May 26, 2026',
              title: 'Outflow: from BDO',
              subtitle: 'BDO',
              amount: '-₱599.00',
              amountColor: Colors.redAccent,
            ),
            const SizedBox(height: 24),

            // YESTERDAY Section Header
            _buildSectionHeader('YESTERDAY'),
            const SizedBox(height: 12),

            // Maynilad Transaction
            _buildTransactionCard(
              date: 'May 25, 2026',
              title: 'Maynilad',
              subtitle: 'GCash · Utilities',
              amount: '-₱980.00',
              amountColor: Colors.redAccent,
            ),
            const SizedBox(height: 12),

            // Cash Outflow Transaction
            _buildTransactionCard(
              date: 'May 25, 2026',
              title: 'Outflow: from Cash',
              subtitle: 'Cash · Transportation',
              amount: '-₱50.00',
              amountColor: Colors.redAccent,
            ),
            const SizedBox(height: 12),

            // Transfer Transaction
            _buildTransactionCard(
              date: 'May 25, 2026',
              title: 'Transfer: from Landbank to...',
              subtitle: 'Landbank → GCash · Savings',
              amount: '₱1,500.00',
              amountColor: const Color(0xFF5856D6), // Vibrant purple/indigo matching the image
            ),
            const SizedBox(height: 24),

            // THIS WEEK Section Header
            _buildSectionHeader('THIS WEEK'),
            const SizedBox(height: 12),

            // Groceries Transaction
            _buildTransactionCard(
              date: 'May 23, 2026',
              title: 'Groceries',
              subtitle: 'Cash · Supermarket',
              amount: '-₱1,250.00',
              amountColor: Colors.redAccent,
            ),
          ],
        ),
      ),
    );
  }

  /// Builds section header titles (e.g., TODAY, YESTERDAY).
  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w900,
        letterSpacing: 1.1,
        color: Colors.black,
      ),
    );
  }

  /// Builds individual transaction item cards matching the exact typography hierarchy.
  /// NOTE: Replace the placeholder Container with ClipRRect and Image.asset when real icons are available.
  Widget _buildTransactionCard({
    required String date,
    required String title,
    required String subtitle,
    required String amount,
    required Color amountColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.0), // Smooth large rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Image / Icon Placeholder Container
          // TODO: Replace this Container with ClipRRect and Image.asset in the future
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(14.0),
            ),
            child: Icon(
              Icons.image_outlined,
              color: Colors.grey.shade400,
              size: 24,
            ),
          ),
          const SizedBox(width: 14),

          // Transaction Text Details (Date on top, Title middle, Subtitle bottom)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  date,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),

          // Transaction Amount Display
          Text(
            amount,
            style: TextStyle(
              fontSize: 14.5,
              fontWeight: FontWeight.bold,
              color: amountColor,
            ),
          ),
        ],
      ),
    );
  }
}