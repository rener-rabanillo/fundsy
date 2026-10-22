import 'package:flutter/material.dart';

/// A reusable category card widget used across different tabs
/// (Incomes, Expenses, Goals, Payables, Receivables) in the Fundsy app.
class CategoryCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String rightTopLabel;
  final String rightBottomLabel;
  final Color themeColor;
  final double? progressValue; // Optional for cards with progress bars (Expenses, Goals, etc.)
  final String? dateText;      // Optional due date or target date text

  const CategoryCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.rightTopLabel,
    required this.rightBottomLabel,
    required this.themeColor,
    this.progressValue,
    this.dateText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: Colors.grey.shade100, width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Category Icon Container with theme color tint
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: themeColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(14.0),
                ),
                child: Icon(icon, color: themeColor, size: 22),
              ),
              const SizedBox(width: 14),

              // Title and Subtitle Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
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
              ),

              // Right side amounts / labels
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    rightTopLabel,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    rightBottomLabel,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Optional Progress Bar for Expenses, Goals, Payables, Receivables
          if (progressValue != null) ...[
            const SizedBox(height: 14),
            ClipRRect(
              borderRadius: BorderRadius.circular(6.0),
              child: LinearProgressIndicator(
                value: progressValue,
                minHeight: 6,
                backgroundColor: Colors.grey.shade100,
                valueColor: AlwaysStoppedAnimation<Color>(themeColor),
              ),
            ),
          ],

          // Optional Date / Remaining text at the bottom
          if (dateText != null) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.calendar_today_rounded, size: 14, color: Colors.grey.shade400),
                const SizedBox(width: 6),
                Text(
                  dateText!,
                  style: TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}