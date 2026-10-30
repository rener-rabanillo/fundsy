import 'package:flutter/material.dart';

/// A bottom sheet widget that allows users to add a new category with dynamic input fields
/// based on the selected category type (Income, Expense, Goal, Payable, Receivable).
class AddCategoryBottomSheet extends StatefulWidget {
  const AddCategoryBottomSheet({super.key});

  @override
  State<AddCategoryBottomSheet> createState() => _AddCategoryBottomSheetState();
}

class _AddCategoryBottomSheetState extends State<AddCategoryBottomSheet> {
  // 0: Income, 1: Expense, 2: Goal, 3: Payable, 4: Receivable
  int _selectedTypeIndex = 0;

  // Common controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _dueDateController = TextEditingController();
  final TextEditingController _interestRateController = TextEditingController();

  // Specific toggles & selections
  bool _isRolloverEnabled = false;
  String? _selectedLoanTerm;
  final List<String> _loanTerms = ['6 months', '12 months', '18 months', '24 months', '36 months'];

  final List<String> _types = ['Income', 'Expense', 'Goal', 'Payable', 'Receivable'];

  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    _dueDateController.dispose();
    _interestRateController.dispose();
    super.dispose();
  }

  /// Opens the native Flutter date picker dialog
  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF1A0B8C), // Header background & selected day color
              onPrimary: Colors.white,
              onSurface: Color(0xFF0F172A),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        // Format date to a clean readable string (e.g., June 30, 2026)
        _dueDateController.text = "${picked.month}/${picked.day}/${picked.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28.0)),
        ),
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Pull-down indicator bar at the top
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Centered Title Header
              const Center(
                child: Text(
                  'Add New Category',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Category Type Selection Chips
              SizedBox(
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _types.length,
                  itemBuilder: (context, index) {
                    bool isSelected = _selectedTypeIndex == index;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ChoiceChip(
                        label: Text(_types[index]),
                        selected: isSelected,
                        selectedColor: const Color(0xFF1A0B8C),
                        labelStyle: TextStyle(
                          color: isSelected ? Colors.white : Colors.grey.shade700,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                        backgroundColor: Colors.grey.shade100,
                        onSelected: (bool selected) {
                          setState(() {
                            _selectedTypeIndex = index;
                            _dueDateController.clear(); // Reset date when switching tabs
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),

              // 1. Common Field: Category Name
              const Text('Category Name', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF1A0B8C))),
              const SizedBox(height: 6),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: _getNameHint(),
                  hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
                  filled: true,
                  fillColor: Colors.grey.shade50,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: Colors.grey.shade200)),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: Colors.grey.shade200)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                ),
              ),
              const SizedBox(height: 16),

              // 2. Dynamic Fields based on Type
              ..._buildDynamicFields(),

              const SizedBox(height: 24),

              // Action Buttons (Cancel and Add Category)
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
                          const SnackBar(content: Text('Category Added Successfully!')),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1A0B8C),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        elevation: 0,
                      ),
                      child: const Text('Add Category', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  /// Returns contextual hint text for the name field depending on the selected type
  String _getNameHint() {
    switch (_selectedTypeIndex) {
      case 0: return 'e.g., Salary, Freelance';
      case 1: return 'e.g., Groceries, Electricity';
      case 2: return 'e.g., New Laptop, Emergency Fund';
      case 3: return 'e.g., Motorcycle Loan, Credit Card';
      case 4: return 'e.g., Greg - Dine Out';
      default: return 'e.g., Category Name';
    }
  }

  /// Generates the corresponding form fields based on the selected category type
  List<Widget> _buildDynamicFields() {
    List<Widget> fields = [];

    // 0: Income (Name and Icon only)
    if (_selectedTypeIndex == 0) {
      return fields;
    }

    // 1: Expense (Budgeted amount + Rollover toggle)
    if (_selectedTypeIndex == 1) {
      fields.addAll([
        const Text('Budgeted Amount', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF1A0B8C))),
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Rollover Enabled',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
            ),
            Switch(
              value: _isRolloverEnabled,
              activeThumbColor: const Color(0xFF1A0B8C),
              onChanged: (value) {
                setState(() {
                  _isRolloverEnabled = value;
                });
              },
            ),
          ],
        ),
      ]);
    }

    // 2: Goal (Target Amount optional, Target Date picker)
    if (_selectedTypeIndex == 2) {
      fields.addAll([
        const Text('Target Amount (optional)', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF1A0B8C))),
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
        const Text('Target Date (optional)', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF1A0B8C))),
        const SizedBox(height: 6),
        GestureDetector(
          onTap: () => _selectDate(context),
          child: AbsorbPointer(
            child: TextField(
              controller: _dueDateController,
              decoration: InputDecoration(
                hintText: 'Select date',
                hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
                filled: true,
                fillColor: Colors.grey.shade50,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: Colors.grey.shade200)),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: Colors.grey.shade200)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                suffixIcon: const Icon(Icons.calendar_today_rounded, size: 18, color: Color(0xFF1A0B8C)),
              ),
            ),
          ),
        ),
      ]);
    }

    // 3: Payable (Borrowed amount, Due date picker + Advanced options)
    if (_selectedTypeIndex == 3) {
      fields.addAll([
        const Text('Borrowed Amount', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF1A0B8C))),
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
        const Text('Due Date (optional)', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF1A0B8C))),
        const SizedBox(height: 6),
        GestureDetector(
          onTap: () => _selectDate(context),
          child: AbsorbPointer(
            child: TextField(
              controller: _dueDateController,
              decoration: InputDecoration(
                hintText: 'Select due date',
                hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
                filled: true,
                fillColor: Colors.grey.shade50,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: Colors.grey.shade200)),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: Colors.grey.shade200)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                suffixIcon: const Icon(Icons.calendar_today_rounded, size: 18, color: Color(0xFF1A0B8C)),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'Advanced Options',
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w900, color: Color(0xFF0F172A)),
        ),
        const SizedBox(height: 12),
        const Text('Monthly Interest Rate (%)', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF1A0B8C))),
        const SizedBox(height: 6),
        TextField(
          controller: _interestRateController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: '0.0%',
            hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
            filled: true,
            fillColor: Colors.grey.shade50,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: Colors.grey.shade200)),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: Colors.grey.shade200)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        ),
        const SizedBox(height: 16),
        const Text('Loan Term', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF1A0B8C))),
        const SizedBox(height: 6),
        DropdownButtonFormField<String>(
          initialValue: _selectedLoanTerm,
          hint: const Text('Select term', style: TextStyle(fontSize: 13, color: Colors.grey)),
          items: _loanTerms.map((term) {
            return DropdownMenuItem(
              value: term,
              child: Text(term, style: const TextStyle(fontSize: 13)),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _selectedLoanTerm = value;
            });
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey.shade50,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: Colors.grey.shade200)),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: Colors.grey.shade200)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        ),
      ]);
    }

    // 4: Receivable (Lent amount, Due date picker)
    if (_selectedTypeIndex == 4) {
      fields.addAll([
        const Text('Lent Amount', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF1A0B8C))),
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
        const Text('Due Date (optional)', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF1A0B8C))),
        const SizedBox(height: 6),
        GestureDetector(
          onTap: () => _selectDate(context),
          child: AbsorbPointer(
            child: TextField(
              controller: _dueDateController,
              decoration: InputDecoration(
                hintText: 'Select due date',
                hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
                filled: true,
                fillColor: Colors.grey.shade50,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: Colors.grey.shade200)),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: Colors.grey.shade200)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                suffixIcon: const Icon(Icons.calendar_today_rounded, size: 18, color: Color(0xFF1A0B8C)),
              ),
            ),
          ),
        ),
      ]);
    }

    return fields;
  }
}