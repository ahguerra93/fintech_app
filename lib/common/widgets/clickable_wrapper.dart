import 'package:fintech_app/common/app_dimens.dart';
import 'package:flutter/material.dart';

class ClickableWrapper extends StatelessWidget {
  const ClickableWrapper({super.key, this.borderRadius, required this.child, this.padding, this.onTap});
  final BorderRadius? borderRadius;
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: borderRadius ?? BorderRadius.circular(AppDimens.radiusXl),
        onTap: onTap,
        child: Padding(padding: padding ?? EdgeInsets.all(AppDimens.spacingMd), child: child),
      ),
    );
  }
}
