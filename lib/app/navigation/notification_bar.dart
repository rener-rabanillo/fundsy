import 'package:flutter/material.dart';
import 'package:fundsy/app/themes/app_colors.dart';

class NotificationBar extends StatefulWidget {
  const NotificationBar({super.key});

  @override
  State<NotificationBar> createState() => _NotificationBarState();
}

class _NotificationBarState extends State<NotificationBar> {
  final List _notifications = [
    {
      'id': '1',
      'section': 'TODAY',
      'icon': Icons.account_balance_wallet_rounded,
      'title': 'Budget Alert',
      'subtitle': 'You have reached 80% of your Food & Dining budget for this month.',
      'time': '10m ago',
      'isUnread': true,
    },
    {
      'id': '2',
      'section': 'TODAY',
      'icon': Icons.receipt_long_rounded,
      'title': 'OCR Receipt Scanned',
      'subtitle': 'Successfully scanned receipt from 7-Eleven amounting to ₱245.00.',
      'time': '2h ago',
      'isUnread': true,
    },
    {
      'id': '3',
      'section': 'YESTERDAY',
      'icon': Icons.savings_rounded,
      'title': 'Savings Goal Update',
      'subtitle': 'Great job! You added ₱1,000 to your Emergency Fund today.',
      'time': 'Yesterday',
      'isUnread': false,
    },
  ];

  void _deleteNotification(String id) {
    setState(() {
      _notifications.removeWhere((item) => item['id'] == id);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Notification deleted'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Mas ibinaba pa natin sa pamamagitan ng mas mataas na top padding (36.0)
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 36.0, 20.0, 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        borderRadius: BorderRadius.circular(8),
                        child: const Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Icon(Icons.arrow_back_ios_new_rounded, size: 20, color: Colors.black87),
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Notifications',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        for (var item in _notifications) {
                          item['isUnread'] = false;
                        }
                      });
                    },
                    child: const Text(
                      'Mark all as read',
                      style: TextStyle(fontSize: 12, color: AppColors.primary, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, thickness: 1, color: Color(0xFFEEEEEE)),

            // Notifications List Body
            Expanded(
              child: _notifications.isEmpty
                  ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.notifications_off_outlined, size: 48, color: Colors.grey.shade400),
                    const SizedBox(height: 12),
                    Text(
                      'No notifications yet',
                      style: TextStyle(fontSize: 14, color: Colors.grey.shade600, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              )
                  : ListView.builder(
                padding: const EdgeInsets.all(20.0),
                physics: const BouncingScrollPhysics(),
                itemCount: _notifications.length,
                itemBuilder: (context, index) {
                  final item = _notifications[index];

                  final String section = item['section'] as String;
                  final String id = item['id'] as String;
                  final IconData icon = item['icon'] as IconData;
                  final String title = item['title'] as String;
                  final String subtitle = item['subtitle'] as String;
                  final String time = item['time'] as String;
                  final bool isUnread = item['isUnread'] as bool;

                  bool showHeader = false;
                  if (index == 0 || (_notifications[index - 1]['section'] as String) != section) {
                    showHeader = true;
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (showHeader) ...[
                        if (index > 0) const SizedBox(height: 16),
                        Text(
                          section,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade500,
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(height: 12),
                      ],
                      Dismissible(
                        key: Key(id),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20),
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: Colors.red.shade400,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Icon(Icons.delete_outline_rounded, color: Colors.white, size: 24),
                        ),
                        onDismissed: (direction) {
                          _deleteNotification(id);
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: isUnread ? AppColors.primary.withValues(alpha: 0.04) : Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isUnread ? AppColors.primary.withValues(alpha: 0.15) : Colors.grey.shade200,
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(icon, color: AppColors.primary, size: 22),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          title,
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: isUnread ? Colors.black87 : Colors.grey.shade700,
                                          ),
                                        ),
                                        Text(
                                          time,
                                          style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      subtitle,
                                      style: TextStyle(fontSize: 13, color: Colors.grey.shade600, height: 1.35),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              GestureDetector(
                                onTap: () => _deleteNotification(id),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Icon(Icons.close_rounded, size: 16, color: Colors.grey.shade400),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}