import 'package:flutter/material.dart';
import 'package:food_delivery/l10n/app_localizations.dart';

import '../constants/app_images.dart';
import '../style/app_text_styles.dart';

class SectionHeading extends StatelessWidget {
  const SectionHeading(this.title, {super.key, this.action});
  final String title;
  final VoidCallback? action;
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: AppTextStyles.heading24BlackBold.copyWith(
                fontSize: 18,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
          if (action != null)
            TextButton(onPressed: action, child: Text(l10n.seeAll)),
        ],
      ),
    );
  }
}

class FoodPhoto extends StatelessWidget {
  const FoodPhoto({super.key, this.height = 115, this.width = double.infinity});
  final double height, width;
  @override
  Widget build(BuildContext context) => ClipRRect(
    borderRadius: BorderRadius.circular(16),
    child: Image.asset(
      AppImages.onboardingFood,
      width: width,
      height: height,
      fit: BoxFit.cover,
      alignment: Alignment.centerRight,
    ),
  );
}

class UiCard extends StatelessWidget {
  const UiCard({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) => Card(
    elevation: 0,
    color: Theme.of(context).colorScheme.surfaceContainerLow,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    child: Padding(padding: const EdgeInsets.all(12), child: child),
  );
}

void showDemo(BuildContext context, [String? message]) =>
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message ?? AppLocalizations.of(context)!.demoPreviewMessage,
        ),
      ),
    );
