import 'package:flutter/material.dart';
import '../theme.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final VoidCallback? onTap;
  final bool ghost;
  const PrimaryButton(this.label, {super.key, this.icon, this.onTap, this.ghost = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 52,
        decoration: BoxDecoration(
          color: ghost ? AppColors.card : AppColors.primary,
          borderRadius: BorderRadius.circular(16),
          border: ghost ? Border.all(color: AppColors.border, width: 2) : null,
          boxShadow: ghost ? null : const [BoxShadow(color: Color(0xFF8E1022), offset: Offset(0, 4))],
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          if (icon != null) ...[Icon(icon, size: 18, color: ghost ? AppColors.ink : Colors.white), const SizedBox(width: 8)],
          Text(label, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: ghost ? AppColors.ink : Colors.white)),
        ]),
      ),
    );
  }
}

class InfoLine extends StatelessWidget {
  final IconData icon;
  final String title, body;
  const InfoLine(this.icon, this.title, this.body, {super.key});
  @override
  Widget build(BuildContext context) => AppCard(
        child: Row(children: [
          IconBox(icon),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
            Text(body, style: const TextStyle(fontSize: 12, color: AppColors.muted)),
          ])),
        ]),
      );
}

class IconBox extends StatelessWidget {
  final IconData icon;
  const IconBox(this.icon, {super.key});
  @override
  Widget build(BuildContext context) => Container(
        width: 40, height: 40,
        decoration: BoxDecoration(color: AppColors.primarySoft, borderRadius: BorderRadius.circular(12)),
        child: Icon(icon, color: AppColors.primary, size: 20),
      );
}

class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  const AppCard({super.key, required this.child, this.padding = const EdgeInsets.all(12)});
  @override
  Widget build(BuildContext context) => Container(
        padding: padding,
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border, width: 2),
        ),
        child: child,
      );
}
