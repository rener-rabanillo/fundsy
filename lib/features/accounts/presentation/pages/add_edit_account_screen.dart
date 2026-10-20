import 'package:flutter/material.dart';

/// AddEditAccountScreen dynamically displays form fields and updates its title
/// based on the selected account type (Cash, E-Wallet, Debit Card, or Credit Card).
class AddEditAccountScreen extends StatefulWidget {
  final String accountType; // 'Cash', 'E-Wallet', 'Debit Card', or 'Credit Card'

  const AddEditAccountScreen({super.key, required this.accountType});

  @override
  State<AddEditAccountScreen> createState() => _AddEditAccountScreenState();
}

class _AddEditAccountScreenState extends State<AddEditAccountScreen> {
  final _nameController = TextEditingController();
  final _balanceController = TextEditingController();
  final _interestController = TextEditingController();
  final _creditLimitController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool isCreditCard = widget.accountType == 'Credit Card';
    bool isDebitCard = widget.accountType == 'Debit Card';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.black, size: 24),
          onPressed: () => Navigator.pop(context),
        ),
        // Dynamic title na nakabase sa piniling account type
        title: Text(
          widget.accountType,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: Color(0xFF0F172A),
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              children: [
                // 1. Account Name Field Container
                _buildFormSection(
                  label: 'Account Name',
                  child: TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      hintText: isCreditCard
                          ? 'e.g. Bank Credit'
                          : isDebitCard
                          ? 'e.g. Bank Debit'
                          : 'e.g. Wallet',
                      hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 15),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // 2. Balance Field Container (Current Balance o Outstanding Balance)
                _buildFormSection(
                  label: isCreditCard ? 'Outstanding Balance' : 'Current Balance',
                  child: TextField(
                    controller: _balanceController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: isCreditCard ? 'e.g. 1,000.00' : 'e.g. 10,000.00',
                      hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 15),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),

                // 3. Optional Extra Field para sa Debit Card (Interest Rate)
                if (isDebitCard) ...[
                  const SizedBox(height: 16),
                  _buildFormSection(
                    label: 'Interest Rate (yearly)',
                    child: TextField(
                      controller: _interestController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'e.g. 0.05%',
                        hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 15),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                ],

                // 4. Dagdag na Fields para sa Credit Card (Credit Limit, Statement Date, Due Date)
                if (isCreditCard) ...[
                  const SizedBox(height: 16),
                  _buildFormSection(
                    label: 'Credit Limit',
                    child: TextField(
                      controller: _creditLimitController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'e.g. 10,000.00',
                        hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 15),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildDateSelectorRow('Statement Date', 'Payment Due Date'),
                ],
              ],
            ),
          ),

          // Bottom Action Buttons (Cancel and Add)
          Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 10,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: Row(
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
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: Implement save logic here
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1A0B8C),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                    ),
                    child: const Text(
                      'Add',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Reusable container para sa bawat form section na may magandang card style
  Widget _buildFormSection({required String label, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22.0),
        border: Border.all(color: Colors.grey.shade100, width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            decoration: BoxDecoration(
              color: const Color(0xFFF8F9FC),
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: child,
          ),
        ],
      ),
    );
  }

  /// Pangkabit para sa date/time selectors ng credit card na ligtas sa overflow
  Widget _buildDateSelectorRow(String label1, String label2) {
    return Row(
      children: [
        Expanded(
          child: _buildFormSection(
            label: label1,
            child: Row(
              children: [
                Icon(Icons.calendar_today_outlined, size: 16, color: Colors.grey.shade400),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    'yy/mm/dd',
                    style: TextStyle(color: Colors.grey.shade400, fontSize: 13),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _buildFormSection(
            label: label2,
            child: Row(
              children: [
                Icon(Icons.access_time_outlined, size: 16, color: Colors.grey.shade400),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    'hh:mm',
                    style: TextStyle(color: Colors.grey.shade400, fontSize: 13),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}