import 'package:flutter/material.dart';
import 'package:fundsy/app/themes/app_colors.dart';
import 'account_screen.dart';
import 'display_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

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
          'Settings',
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
          Text(
            'GENERAL',
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
            child: Column(
              children: [
                _buildSettingItem(
                  icon: Icons.account_circle_rounded,
                  title: 'Account',
                  subtitle: 'Manage your profile and account details',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const AccountScreen()),
                  ),
                ),
                Divider(height: 1, indent: 64, endIndent: 16, color: Colors.grey.shade100),
                _buildSettingItem(
                  icon: Icons.contrast_rounded,
                  title: 'Display',
                  subtitle: 'Theme appearance and layout options',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const DisplayScreen()),
                  ),
                ),
                Divider(height: 1, indent: 64, endIndent: 16, color: Colors.grey.shade100),
                _buildSettingItem(
                  icon: Icons.notifications_rounded,
                  title: 'Notifications',
                  subtitle: 'Budget alerts, reminders, and updates',
                  onTap: () {
                    // TODO: Add Notifications screen later
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'PRIVACY & SAFETY',
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
            child: Column(
              children: [
                _buildSettingItem(
                  icon: Icons.lock_rounded,
                  title: 'Privacy',
                  subtitle: 'Data permissions and visibility preferences',
                  onTap: () {
                    // TODO: Add Privacy screen later
                  },
                ),
                Divider(height: 1, indent: 64, endIndent: 16, color: Colors.grey.shade100),
                _buildSettingItem(
                  icon: Icons.shield_rounded,
                  title: 'Security',
                  subtitle: 'Password, app lock, and protection settings',
                  onTap: () {
                    // TODO: Add Security screen later
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 14.0),
        child: Row(
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
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right_rounded, color: Colors.grey.shade400, size: 22),
          ],
        ),
      ),
    );
  }
}