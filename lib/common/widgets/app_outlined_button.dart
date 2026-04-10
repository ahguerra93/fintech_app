import 'package:fintech_app/common/app_dimens.dart';
import 'package:flutter/material.dart';

class AppOutlinedButton extends StatelessWidget {
  const AppOutlinedButton({super.key, required this.label, required this.onPressed, this.borderColor, this.textColor});

  final String label;
  final VoidCallback? onPressed;
  final Color? borderColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    final effectiveBorderColor = borderColor ?? Theme.of(context).colorScheme.primary;
    final effectiveTextColor = textColor ?? Theme.of(context).colorScheme.primary;

    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: effectiveBorderColor),
          foregroundColor: effectiveTextColor,
          padding: const EdgeInsets.symmetric(vertical: AppDimens.spacingMd),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDimens.radiusMd)),
        ),
        child: Text(label),
      ),
    );
  }
}
