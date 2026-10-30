import 'package:flutter/material.dart';

/// A bottom sheet widget that allows users to manually add Inflow, Outflow, or Transfer transactions.
class ManualEntryBottomSheet extends StatefulWidget {
  const ManualEntryBottomSheet({super.key});

  @override
  State<ManualEntryBottomSheet> createState() => _ManualEntryBottomSheetState();
}

class _ManualEntryBottomSheetState extends State<ManualEntryBottomSheet> {
  // Tracks the active tab index: 0 for Inflow, 1 for Outflow, 2 for Transfer
  int _selectedTabIndex = 0;

  final TextEditingController _payeeController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  String? _selectedAccount;
  String? _selectedDestinationAccount;
  String? _selectedCategory;

  @override
  void dispose() {
    _payeeController.dispose();
    _amountController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28.0)),
      ),
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Transaction Type Selector Tabs (Inflow, Outflow, Transfer)
            Row(
              children: [
                Expanded(child: _buildTypeTab('Inflow', 0, Colors.green)),
                const SizedBox(width: 8),
                Expanded(child: _buildTypeTab('Outflow', 1, Colors.redAccent)),
                const SizedBox(width: 8),
                Expanded(child: _buildTypeTab('Transfer', 2, const Color(0xFF1A0B8C))),
              ],
            ),
            const SizedBox(height: 20),

            // Date and Time Row
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.calendar_today_rounded, size: 18, color: Color(0xFF1A0B8C)),
                        SizedBox(width: 8),
                        Text('2026/10/29', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.access_time_rounded, size: 18, color: Color(0xFF1A0B8C)),
                        SizedBox(width: 8),
                        Text('11:26', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Payee Field (Optional)
            const Text('Payee (optional)', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF1A0B8C))),
            const SizedBox(height: 6),
            TextField(
              controller: _payeeController,
              decoration: InputDecoration(
                hintText: 'e.g., Company, Convenience Store',
                hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
                filled: true,
                fillColor: Colors.grey.shade50,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: Colors.grey.shade200)),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: Colors.grey.shade200)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
            ),
            const SizedBox(height: 16),

            // Amount Field
            const Text('Amount', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF1A0B8C))),
            const SizedBox(height: 6),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: '0.00',
                hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
                filled: true,
                fillColor: Colors.grey.shade50,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: Colors.grey.shade200)),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: Colors.grey.shade200)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
            ),
            const SizedBox(height: 16),

            // Conditional Account / Transfer fields based on selected tab
            if (_selectedTabIndex == 2) ...[
              // Source Account for Transfer
              const Text('Source Account', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF1A0B8C))),
              const SizedBox(height: 6),
              _buildDropdownField('Select account', _selectedAccount, (val) => setState(() => _selectedAccount = val)),
              const SizedBox(height: 16),

              // Destination Account for Transfer
              const Text('Destination Account', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF1A0B8C))),
              const SizedBox(height: 6),
              _buildDropdownField('Select destination', _selectedDestinationAccount, (val) => setState(() => _selectedDestinationAccount = val)),
            ] else ...[
              // Single Account for Inflow/Outflow
              const Text('Account', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF1A0B8C))),
              const SizedBox(height: 6),
              _buildDropdownField('Select account', _selectedAccount, (val) => setState(() => _selectedAccount = val)),
              const SizedBox(height: 16),

              // Category (Optional) for Inflow/Outflow
              const Text('Category (optional)', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF1A0B8C))),
              const SizedBox(height: 6),
              _buildDropdownField('Select category', _selectedCategory, (val) => setState(() => _selectedCategory = val)),
            ],
            const SizedBox(height: 16),

            // Notes Field
            const Text('Notes', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF1A0B8C))),
            const SizedBox(height: 6),
            TextField(
              controller: _notesController,
              maxLines: 2,
              decoration: InputDecoration(
                hintText: 'Write your notes here...',
                hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
                filled: true,
                fillColor: Colors.grey.shade50,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: Colors.grey.shade200)),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: Colors.grey.shade200)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
            ),
            const SizedBox(height: 24),

            // Action Buttons (Cancel and Add)
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      side: const BorderSide(color: Color(0xFF1A0B8C)),
                    ),
                    child: const Text('Cancel', style: TextStyle(color: Color(0xFF1A0B8C), fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Transaction Added Successfully!')),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1A0B8C),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      elevation: 0,
                    ),
                    child: const Text('Add', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Builds individual transaction type tab (Inflow, Outflow, Transfer).
  Widget _buildTypeTab(String title, int index, Color activeColor) {
    bool isSelected = _selectedTabIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedTabIndex = index),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? activeColor.withValues(alpha: 0.1) : Colors.grey.shade50,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? activeColor : Colors.grey.shade200,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? activeColor : Colors.grey.shade600,
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  /// Helper for dropdown selection fields.
  Widget _buildDropdownField(String hint, String? selectedValue, ValueChanged<String?> onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedValue,
          hint: Text(hint, style: TextStyle(color: Colors.grey.shade400, fontSize: 13)),
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.grey),
          items: <String>['Main Wallet', 'Savings Account', 'Cash'].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value, style: const TextStyle(fontSize: 13)),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}