import 'package:fintech_app/common/app_dimens.dart';
import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({super.key, required this.title, this.subtitle, this.onTap});
  final String title;
  final String? subtitle;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium),

        if (subtitle != null)
          InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(AppDimens.radiusMd),
            child: Text(
              subtitle!,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Theme.of(context).colorScheme.primary),
            ),
          ),
      ],
    );
  }
}
