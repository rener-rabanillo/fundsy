import 'package:flutter/material.dart';
import 'package:fundsy/app/themes/app_colors.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool _enableReminders = true;
  bool _logExpensesReminder = true;
  bool _enableBillReminders = true;
  bool _budgetLimitAlerts = true;
  TimeOfDay _reminderTime = const TimeOfDay(hour: 20, minute: 0); // 8:00 PM default

  Future<void> _pickReminderTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _reminderTime,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() => _reminderTime = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: AppColors.primary, size: 24),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Notifications',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        children: [
          // MASTER SWITCH SECTION
          Text(
            'PREFERENCES',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade500,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: SwitchListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              secondary: Container(
                padding: const EdgeInsets.all(9),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.notifications_active_rounded, color: AppColors.primary, size: 20),
              ),
              title: const Text(
                'Enable Reminders',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              subtitle: Text(
                _enableReminders ? 'All notifications and alerts are active' : 'All reminders are turned off',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
              activeThumbColor: AppColors.primary,
              value: _enableReminders,
              onChanged: (value) => setState(() => _enableReminders = value),
            ),
          ),

          const SizedBox(height: 24),

          // REMINDERS & ALERTS SECTION
          Text(
            'REMINDERS & ALERTS',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade500,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 10),
          AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: _enableReminders ? 1.0 : 0.45,
            child: IgnorePointer(
              ignoring: !_enableReminders,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  children: [
                    // 1. Remind me to log my expenses
                    SwitchListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                      secondary: Container(
                        padding: const EdgeInsets.all(9),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.edit_calendar_rounded, color: AppColors.primary, size: 20),
                      ),
                      title: const Text(
                        'Remind me to log my expenses',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      subtitle: Text(
                        'Daily check-in to record your spending',
                        style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                      ),
                      activeThumbColor: AppColors.primary,
                      value: _logExpensesReminder,
                      onChanged: (value) => setState(() => _logExpensesReminder = value),
                    ),

                    // Optional Time Picker sub-row when "Remind me to log my expenses" is enabled
                    if (_logExpensesReminder) ...[
                      Divider(height: 1, indent: 58, endIndent: 14, color: Colors.grey.shade100),
                      InkWell(
                        onTap: _pickReminderTime,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(58, 10, 16, 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Daily reminder time',
                                style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withValues(alpha: 0.08),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  _reminderTime.format(context),
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],

                    Divider(height: 1, indent: 58, endIndent: 14, color: Colors.grey.shade100),

                    // 2. Enable bill reminders
                    SwitchListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                      secondary: Container(
                        padding: const EdgeInsets.all(9),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.receipt_long_rounded, color: AppColors.primary, size: 20),
                      ),
                      title: const Text(
                        'Enable bill reminders',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      subtitle: Text(
                        'Get notified before recurring bills are due',
                        style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                      ),
                      activeThumbColor: AppColors.primary,
                      value: _enableBillReminders,
                      onChanged: (value) => setState(() => _enableBillReminders = value),
                    ),

                    Divider(height: 1, indent: 58, endIndent: 14, color: Colors.grey.shade100),

                    // 3. Budget Limit Alerts
                    SwitchListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                      secondary: Container(
                        padding: const EdgeInsets.all(9),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.account_balance_wallet_rounded, color: AppColors.primary, size: 20),
                      ),
                      title: const Text(
                        'Budget limit alerts',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      subtitle: Text(
                        'Alert when spending reaches 80% of your budget',
                        style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                      ),
                      activeThumbColor: AppColors.primary,
                      value: _budgetLimitAlerts,
                      onChanged: (value) => setState(() => _budgetLimitAlerts = value),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}