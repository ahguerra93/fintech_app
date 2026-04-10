import 'package:fintech_app/app_colors.dart';
import 'package:fintech_app/common/app_dimens.dart';
import 'package:flutter/material.dart';

class AppLabeledField extends StatelessWidget {
  const AppLabeledField({
    super.key,
    required this.label,
    required this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.style,
    this.labelStyle,
    this.fillColor,
    this.suffixIcon,
  });

  final String label;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final TextStyle? style;
  final TextStyle? labelStyle;
  final Color? fillColor;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    final themeExt = Theme.of(context).extension<AppColorTheme>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style:
              labelStyle ??
              Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: AppDimens.spacingXs),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          style: style ?? TextStyle(color: themeExt?.textPrimary),
          decoration: InputDecoration(fillColor: fillColor ?? Colors.white, suffixIcon: suffixIcon),
        ),
      ],
    );
  }
}
