import 'package:flutter/material.dart';

/// AccountCard is a reusable, modern fintech-styled widget used for
/// both main account list items and modal options with top-aligned elements.
class AccountCard extends StatelessWidget {
  final IconData? iconData;
  final String title;
  final String? subtitle;
  final String? balanceLabel;
  final String? balanceValue;
  final bool isSelected;
  final VoidCallback? onTap;
  final Widget? trailing;

  const AccountCard({
    super.key,
    this.iconData,
    required this.title,
    this.subtitle,
    this.balanceLabel,
    this.balanceValue,
    this.isSelected = false,
    this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 18.0),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1A0B8C).withValues(alpha: 0.04) : Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
            color: isSelected ? const Color(0xFF1A0B8C) : Colors.grey.shade200,
            width: isSelected ? 2.0 : 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        // Ginawa nating CrossAxisAlignment.start para sumagad sa taas ang icon at teksto
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon na nakasagad sa itaas ng card
            Padding(
              padding: const EdgeInsets.only(top: 2.0), // Kaunting adjustment para pantay sa unang linyang teksto
              child: Icon(
                iconData ?? Icons.image_outlined,
                size: 26.0,
                color: isSelected ? const Color(0xFF1A0B8C) : const Color(0xFF0F172A),
              ),
            ),
            const SizedBox(width: 16.0),

            // Title and Subtitle container
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: subtitle != null ? 15.5 : 15.0,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? const Color(0xFF1A0B8C) : const Color(0xFF0F172A),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2.0),
                    Text(
                      subtitle!,
                      style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 8),

            // Trailing widget (e.g., Switch) or Account Balance details
            if (trailing != null) ...[
              trailing!,
            ] else if (balanceLabel != null && balanceValue != null) ...[
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    balanceLabel!,
                    style: TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade400,
                    ),
                  ),
                  const SizedBox(height: 2.0),
                  Text(
                    balanceValue!,
                    style: const TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}